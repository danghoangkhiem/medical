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

  @override
  SynchronizationState get initialState => SynchronizationState.synchronized();

  @override
  Stream<SynchronizationState> mapEventToState(
    SynchronizationEvent event,
  ) async* {
    if (event.type == SynchronizationEventType.check) {
      final _total =
          await _syncRepository.quantityNotSynchronizedByUserId(event.userId);
      if (_total == 0) {
        yield SynchronizationState.synchronized();
      } else {
        yield SynchronizationState.notSynchronized(_total);
      }
    }
    if (event.type == SynchronizationEventType.sync) {
      yield SynchronizationState.synchronizing(
          currentState.process, currentState.total);
      Map<String, dynamic> _consumerRawData =
          await _syncRepository.getNotSynchronizedByUserId(event.userId);
      ConsumerModel _consumerLocally;
      while (_consumerRawData != null &&
          currentState.process < currentState.total) {
        yield SynchronizationState.synchronizing(
            currentState.process + 1, currentState.total);
        _consumerLocally = ConsumerModel.fromJson(_consumerRawData);
        try {
          ConsumerModel _consumerResult =
              await _consumerRepository.addConsumer(_consumerLocally);
          await _consumerRepository.setConsumerLocally(
              _consumerRawData['_id'], _consumerResult);
        } catch (error, trace) {
          print(error);
          print(trace);
        }
        _consumerRawData =
            await _syncRepository.getNotSynchronizedByUserId(event.userId);
      }
      yield SynchronizationState.synchronized();
    }
    if (event.type == SynchronizationEventType.hasData) {
      yield SynchronizationState.notSynchronized(currentState.total + 1);
    }
  }
}
