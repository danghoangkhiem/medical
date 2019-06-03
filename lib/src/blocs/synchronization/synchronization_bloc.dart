import 'dart:async';

import 'package:bloc/bloc.dart';

import 'synchronization.dart';

import 'package:medical/src/resources/sync_repository.dart';

class SynchronizationBloc
    extends Bloc<SynchronizationEvent, SynchronizationState> {
  final SyncRepository _syncRepository = SyncRepository();

  @override
  SynchronizationState get initialState =>
      SynchronizationState.notSynchronized(0);

  @override
  Stream<SynchronizationState> mapEventToState(
    SynchronizationEvent event,
  ) async* {
    if (event.type == SynchronizationEventType.check) {
      final _synced = await _syncRepository.synced();
      if (_synced) {
        yield SynchronizationState.synchronized();
      } else {
        final _quantity = await _syncRepository.quantityNotSynchronized();
        yield SynchronizationState.notSynchronized(_quantity);
      }
    }
    if (event.type == SynchronizationEventType.sync) {
      await Future.delayed(Duration(seconds: 20));
      yield SynchronizationState.synchronized();
    }
    if (event.type == SynchronizationEventType.hasData) {
      yield SynchronizationState.notSynchronized(currentState.quantity + 1);
    }
  }
}
