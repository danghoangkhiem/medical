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

  bool _hadFound = false;

  ConsumerListModel _consumerHistory;

  ConsumerListModel get consumerHistory => _consumerHistory;
  //set searchPhoneHistory(ConsumerListModel value) {}

  bool get hasFound => _hadFound;
  //set hasFound(bool value) {}

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
      _hadFound = false;
      try {
        ConsumerModel _consumer =
            await _consumerRepository.findPhoneNumber(event.phoneNumber);
        if (_consumer == null) {
          _consumer = ConsumerModel(
              phoneNumber: event.phoneNumber,
              additionalData: AdditionalDataModel.fromJson(
                  defaultConsumerInformation().additionalData.toJson()));
          _hadFound = false;
          _consumerHistory = ConsumerListModel.fromJson([]);
        } else {
          // set default additional data
          _consumer.additionalData = AdditionalDataModel.fromJson(
              defaultConsumerInformation().additionalData.toJson());
          _hadFound = true;
          _consumerHistory = await _consumerRepository
              .getListConsumerByPhoneNumber(_consumer.phoneNumber,
                  offset: 0, limit: 2);
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
      if (currentState.currentStep < 3 && _hadFound) {
        yield Stepped(3, consumer: event.consumer);
        return;
      }
      if (currentState.currentStep == 3) {
        bool hasSampled = currentState.consumer.additionalData.samples.any(
            (item) =>
                item.value != null && int.tryParse(item.value.toString()) > 0);
        bool hasPurchased = currentState.consumer.additionalData.purchases.any(
            (item) =>
                item.value != null && int.tryParse(item.value.toString()) > 0);
        if (!hasSampled && !hasPurchased) {
          yield Stepped(
            3,
            consumer: event.consumer,
            error:
                'Thông tin khách hàng không hợp lệ. Khách hàng cần phải mua hàng khi không nhận samping và ngược lại',
          );
          return;
        }
      }
      if (currentState.currentStep == 5) {
        yield Loading();
        await Future.delayed(Duration(milliseconds: 200));
        try {
          await _consumerRepository.addConsumerLocally(event.consumer);
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
      if (currentState.currentStep <= 3 && _hadFound) {
        yield Stepped(1, consumer: currentState.consumer);
        return;
      }
      yield Stepped(currentState.currentStep - 1,
          consumer: currentState.consumer);
    }
  }
}
