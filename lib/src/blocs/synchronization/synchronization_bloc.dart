import 'dart:async';
import 'package:bloc/bloc.dart';
import './synchronization.dart';

class SynchronizationBloc extends Bloc<SynchronizationEvent, SynchronizationState> {
  @override
  SynchronizationState get initialState => InitialSynchronizationState();

  @override
  Stream<SynchronizationState> mapEventToState(
    SynchronizationEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
