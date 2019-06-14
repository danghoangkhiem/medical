import 'dart:async';

import 'package:bloc/bloc.dart';

import 'customer_manage.dart';

import 'package:medical/src/resources/customer_manage_repository.dart';
import 'package:medical/src/models/attendance_model.dart';
import 'package:medical/src/resources/user_repository.dart';

class CustomerManageBloc
    extends Bloc<CustomerManageEvent, CustomerManageState> {
  final CustomerManageRepository _customerManageRepository =
      CustomerManageRepository();

  final UserRepository _userRepository = UserRepository();

  String _customerType;
  String _customerStatus;
  int _currentOffset;
  int _currentLimit;
  int _timeIn;

  @override
  CustomerManageState get initialState => InitialCustomerManageState();

  @override
  Stream<CustomerManageState> mapEventToState(
    CustomerManageEvent event,
  ) async* {
    if (event is CustomerManageEventFilter) {
      yield Loading();
      try {
        if (event.customerType == null || event.customerStatus == null) {
          throw 'Phải chọn loại và tình trạng';
        }
        AttendanceModel attendance =
        await _userRepository.getAttendanceLastTimeLocally();

        if (attendance == null || attendance.timeOut != null) {
          throw 'Bạn chưa chấm công vào';
        }
        _currentOffset = event.offset;
        _currentLimit = event.limit;
        _customerType = event.customerType;
        _customerStatus = event.customerStatus;
        _timeIn = attendance.timeIn.millisecondsSinceEpoch~/1000;

        final _customerManagerList =
            await _customerManageRepository.getCustomerByTypeAndStatus(_timeIn, _currentOffset, _currentLimit, _customerType, _customerStatus);
        if (_customerManagerList.length == 0) {
          yield NoRecordsFound();
        } else {
          yield Loaded(customerManagerList: _customerManagerList);
        }
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is LoadMore) {
      yield Loading(isLoadMore: true);
      try {
        AttendanceModel attendance =
        await _userRepository.getAttendanceLastTimeLocally();

        _currentOffset = _currentOffset + _currentLimit;
        _currentLimit = _currentLimit;
        _timeIn = attendance.timeIn.millisecondsSinceEpoch~/1000;

        final _customerManagerList =
        await _customerManageRepository.getCustomerByTypeAndStatus(_timeIn, _currentOffset, _currentLimit, _customerType, _customerStatus);
        if (_customerManagerList == null || _customerManagerList.length == 0) {
          yield ReachMax();
        } else {
          yield Loaded(
              customerManagerList: _customerManagerList, isLoadMore: true);
        }
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
