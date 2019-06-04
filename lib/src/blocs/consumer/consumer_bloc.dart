import 'dart:async';

import 'package:bloc/bloc.dart';

import 'consumer.dart';

import 'package:medical/src/resources/consumer_repository.dart';

import 'package:medical/src/models/additional_data_model.dart';
import 'package:medical/src/models/consumer_model.dart';

class ConsumerBloc extends Bloc<ConsumerEvent, ConsumerState> {
  final ConsumerRepository _consumerRepository = ConsumerRepository();

  AdditionalDataModel _additionalFields;

  AdditionalDataModel get additionalFields => _additionalFields;

  @override
  ConsumerState get initialState => Initial();

  @override
  Stream<ConsumerState> mapEventToState(
    ConsumerEvent event,
  ) async* {
    if (event is AdditionalFields) {
      yield Loading();
      try {
        _additionalFields = await _consumerRepository.getAdditionalFields();
        yield Loaded(additionalFields: _additionalFields);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is SearchPhoneNumber) {
      yield Searching();
      try {
        ConsumerModel _consumer =
            await _consumerRepository.findPhoneNumber(event.phoneNumber);
        if (_consumer == null) {
          _consumer = currentState.consumer..phoneNumber = event.phoneNumber;
        }
        yield FinishedSearching();
        yield Stepped(1, consumer: _consumer);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is NextStep) {
      yield Stepped(currentState.currentStep + 1, consumer: event.consumer);
    }
    if (event is PrevStep) {
      yield Stepped(currentState.currentStep - 1,
          consumer: currentState.consumer);
    }
  }
}
