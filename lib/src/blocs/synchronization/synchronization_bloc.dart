import 'dart:async';

import 'package:bloc/bloc.dart';

import 'synchronization.dart';

import 'package:medical/src/models/consumer_model.dart';

import 'package:medical/src/resources/consumer_repository.dart';
import 'package:medical/src/resources/sync_repository.dart';

class SynchronizationBloc
    extends Bloc<SynchronizationEvent, SynchronizationState> {
  final SyncRepository _syncRepository = SyncRepository();
  final ConsumerRepository _consumerRepository = ConsumerRepository();

  int _downloaded = 0;
  int _uploaded = 0;
  int _total = 0;

  @override
  SynchronizationState get initialState => SynchronizationState.synchronized();

  @override
  Stream<SynchronizationState> mapEventToState(
    SynchronizationEvent event,
  ) async* {
    if (event.type == SynchronizationEventType.check) {
      _total =
          await _syncRepository.quantityNotSynchronizedByUserId(event.userId);
      if (_total == 0) {
        yield SynchronizationState.synchronized();
      } else {
        yield SynchronizationState.notSynchronized(_total);
      }
    }
    if (event.type == SynchronizationEventType.sync) {
      yield* _downloading(event);
      yield* _uploading(event);
      yield SynchronizationState.synchronized(
        downloaded: _downloaded,
        uploaded: _uploaded,
        total: _total,
      );
    }
    if (event.type == SynchronizationEventType.download) {
      yield* _downloading(event);
      yield SynchronizationState.synchronized(downloaded: _downloaded);
    }
    if (event.type == SynchronizationEventType.compact) {
      yield SynchronizationState.synchronizing();
      await _consumerRepository.truncateTable();
      yield* _downloading(event);
      yield SynchronizationState.synchronized(downloaded: _downloaded);
    }
    if (event.type == SynchronizationEventType.hasData) {
      yield SynchronizationState.notSynchronized(++_total);
    }
  }

  Stream<SynchronizationState> _downloading(SynchronizationEvent event) async* {
    yield SynchronizationState.downloading(0);
    try {
      ConsumerModel _consumer = await _consumerRepository.getLastLocally();
      ConsumerListModel _consumers;
      int limit = 20;
      do {
        _consumers = await _consumerRepository.getConsumerList(
          offset: 0,
          limit: limit,
          idGreaterThan: _consumer?.id ?? 0,
          sort: 'asc',
        );
        for (_consumer in _consumers) {
          await _consumerRepository.insertConsumerLocally(_consumer);
        }
        yield SynchronizationState.downloading(
          _downloaded = _downloaded + _consumers?.length,
        );
      } while (_consumers != null && _consumers.length == limit);
    } catch (error, trace) {
      print(error);
      print(trace);
    }
  }

  Stream<SynchronizationState> _uploading(SynchronizationEvent event) async* {
    try {
      ConsumerModel _consumerLocally;
      ConsumerModel _consumer;
      Map<String, dynamic> _consumerRawDataLocally =
          await _syncRepository.getNotSynchronizedByUserId(event.userId);
      yield SynchronizationState.uploading(
        _uploaded = 0,
        _total =
            await _syncRepository.quantityNotSynchronizedByUserId(event.userId),
      );
      while (_consumerRawDataLocally != null && _uploaded < _total) {
        _consumerLocally = ConsumerModel.fromJson(_consumerRawDataLocally);
        try {
          _consumer = await _consumerRepository.addConsumer(_consumerLocally);
          await _consumerRepository.setConsumerLocally(
            _consumerRawDataLocally['_id'],
            _consumer,
          );
          yield SynchronizationState.uploading(
            _uploaded = _uploaded + 1,
            _total,
          );
        } catch (error, trace) {
          print(error);
          print(trace);
        }
        _consumerRawDataLocally =
            await _syncRepository.getNotSynchronizedByUserId(event.userId);
      }
    } catch (error, trace) {
      print(error);
      print(trace);
    }
  }
}
