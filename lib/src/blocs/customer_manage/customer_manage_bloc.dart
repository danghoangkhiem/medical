import 'dart:async';

import 'package:bloc/bloc.dart';

import 'customer_manage.dart';

import 'package:medical/src/resources/customer_manage_repository.dart';
import 'package:medical/src/models/attendance_model.dart';
import 'package:medical/src/resources/user_repository.dart';
import 'package:medical/src/models/user_model.dart';

class CustomerManageBloc
    extends Bloc<CustomerManageEvent, CustomerManageState> {
  final CustomerManageRepository _customerManageRepository =
      CustomerManageRepository();

  final UserRepository _userRepository = UserRepository();

  String _customerType;
  String _customerStatus;

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
        AttendanceModel attendanceModel =
        await _userRepository.getAttendanceLastTimeLocally();
        UserModel userModel = await _userRepository.getInfo();
        int userId = userModel.id;
        int timeIn = attendanceModel.timeIn.millisecondsSinceEpoch~/1000;
        final _customerManagerList =
            await _customerManageRepository.getCustomers(timeIn, userId, _customerType = event.customerType, _customerStatus = event.customerStatus);
        yield Loaded(customerManagerList: _customerManagerList);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is LoadMore) {
      yield Loading(isLoadMore: true);
      try {
        AttendanceModel attendanceModel =
        await _userRepository.getAttendanceLastTimeLocally();
        UserModel userModel = await _userRepository.getInfo();
        int userId = userModel.id;
        int timeIn = attendanceModel.timeIn.millisecondsSinceEpoch~/1000;
        final _customerManagerList =
        await _customerManageRepository.getCustomers(timeIn, userId, _customerType, _customerStatus);
        yield Loaded(
            customerManagerList: _customerManagerList, isLoadMore: true);
      } catch (error,stack) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
