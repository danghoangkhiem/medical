import 'dart:async';

import 'package:bloc/bloc.dart';

import 'customer_manage.dart';

import 'package:medical/src/resources/customer_manage_repository.dart';

class CustomerManageBloc
    extends Bloc<CustomerManageEvent, CustomerManageState> {
  final CustomerManageRepository _customerManageRepository =
      CustomerManageRepository();

  String _customerType;
  String _customerStatus;
  int _currentOffset;
  int _currentLimit;

  @override
  CustomerManageState get initialState => InitialCustomerManageState();

  @override
  Stream<CustomerManageState> mapEventToState(
    CustomerManageEvent event,
  ) async* {
    if (event is CustomerManageEventFilter) {
      yield Loading();
      try {
        final _customerManagerList =
            await _customerManageRepository.getCustomerByTypeAndStatus(
          customerType: _customerType = event.customerType,
          customerStatus: _customerStatus = event.customerStatus,
          offset: _currentOffset = event.offset,
          limit: _currentLimit = event.limit,
        );
        yield Loaded(customerManagerList: _customerManagerList);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is LoadMore) {
      yield Loading(isLoadMore: true);
      try {
        final _customerManagerList =
            await _customerManageRepository.getCustomerByTypeAndStatus(
          customerType: _customerType,
          customerStatus: _customerStatus,
          offset: _currentOffset = _currentOffset + _currentLimit,
          limit: _currentLimit,
        );
        yield Loaded(
            customerManagerList: _customerManagerList, isLoadMore: true);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
