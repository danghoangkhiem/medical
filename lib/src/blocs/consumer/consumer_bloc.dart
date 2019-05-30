import 'dart:async';

import 'package:bloc/bloc.dart';

import 'consumer.dart';

import 'package:medical/src/resources/consumer_repository.dart';

import 'package:medical/src/models/consumer_model.dart';

class ConsumerBloc extends Bloc<ConsumerEvent, ConsumerState> {
  final ConsumerRepository _consumerRepository = ConsumerRepository();

  ConsumerModel consumer;

  @override
  ConsumerState get initialState => Initial();

  @override
  Stream<ConsumerState> mapEventToState(
    ConsumerEvent event,
  ) async* {
    if (event is GetAdditionalFields) {
      yield Loading();
      try {
        final _additionalFields =
            await _consumerRepository.getAdditionalFields();
        yield Loaded(additionalFields: _additionalFields);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is SearchPhoneNumber) {
      yield Searching();
      try {
        consumer = await _consumerRepository.findPhoneNumber(event.phoneNumber);
        yield FinishedSearching();
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is NextStepButtonPressed) {
      yield Stepped(currentState.currentStep + 1);
    }
  }
}
