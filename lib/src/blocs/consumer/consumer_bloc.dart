import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:medical/src/blocs/synchronization/synchronization.dart';
import 'consumer.dart';

import 'package:medical/src/resources/consumer_repository.dart';
import 'package:medical/src/resources/user_repository.dart';

import 'package:medical/src/models/additional_data_model.dart';
import 'package:medical/src/models/attendance_model.dart';
import 'package:medical/src/models/consumer_model.dart';
import 'package:medical/src/models/user_model.dart';

class ConsumerBloc extends Bloc<ConsumerEvent, ConsumerState> {
  final SynchronizationBloc _synchronizationBloc;
  final ConsumerRepository _consumerRepository = ConsumerRepository();
  final UserRepository _userRepository = UserRepository();

  ConsumerBloc({@required SynchronizationBloc synchronizationBloc})
      : assert(synchronizationBloc != null),
        _synchronizationBloc = synchronizationBloc;

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
        bool isAttendanceTimeIn =
            await _userRepository.isAttendanceTimeInLocally();
        if (!isAttendanceTimeIn) {
          throw 'Bạn chưa chấm công vào trên hệ thống';
        }
        _additionalFields =
            await _consumerRepository.getAdditionalFieldsLocally();
        if (_additionalFields == null) {
          throw 'Bạn chưa đồng bộ dữ liệu';
        }
        yield Loaded(additionalFields: _additionalFields);
      } catch (error) {
        yield FatalError(errorMessage: error.toString());
      }
    }
    if (event is SearchPhoneNumber) {
      yield Searching();
      try {
        ConsumerModel _consumer =
            await _consumerRepository.findPhoneNumber(event.phoneNumber);
        if (_consumer == null) {
          _consumer = ConsumerModel(
              phoneNumber: event.phoneNumber,
              additionalData: AdditionalDataModel.fromJson(
                  defaultConsumerInformation().additionalData.toJson()));
        }
        AttendanceModel _attendanceLastTime =
            await _userRepository.getAttendanceLastTimeLocally();
        UserModel _userInfo = await _userRepository.getInfoLocally();
        if (_userInfo == null || _attendanceLastTime == null) {
          throw 'Unexpected Error';
        }
        _consumer
          ..locationId = _attendanceLastTime.location.id
          ..createdAt = DateTime.now()
          ..createdBy = _userInfo.id;
        yield FinishedSearching();
        yield Stepped(1, consumer: _consumer);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is NextStep) {
      if (currentState.currentStep == 5) {
        yield Loading();
        await Future.delayed(Duration(seconds: 1));
        try {
          await _consumerRepository.addConsumer(event.consumer);
          yield Added();
          _synchronizationBloc.dispatch(SynchronizationEvent.hasData());
          await Future.delayed(Duration(seconds: 2));
          yield Initial();
        } catch (error) {
          yield Stepped(5, consumer: event.consumer, error: error.toString());
        }
      } else {
        yield Stepped(currentState.currentStep + 1, consumer: event.consumer);
      }
    }
    if (event is PrevStep) {
      yield Stepped(currentState.currentStep - 1,
          consumer: currentState.consumer);
    }
  }
}
