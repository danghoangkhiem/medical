import 'dart:async';

import 'package:bloc/bloc.dart';

import 'invoice.dart';

import 'package:medical/src/resources/inventory_repository.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final InventoryRepository _inventoryRepository = InventoryRepository();

  DateTime _currentStartDate;
  DateTime _currentEndDate;
  int _currentOffset;
  int _currentLimit;

  @override
  InvoiceState get initialState => InitialInvoiceState();

  @override
  Stream<InvoiceState> mapEventToState(
    InvoiceEvent event,
  ) async* {
    if (event is InvoiceFilter) {
      yield Loading();
      try {
        if (event.startDate == null || event.endDate == null) {
          throw 'Phải chọn thời gian';
        }
        final _invoiceList =
            await _inventoryRepository.getInvoiceAccordingToDateTime(
          startDate: _currentStartDate = event.startDate,
          endDate: _currentEndDate = event.endDate,
          offset: _currentOffset = event.offset,
          limit: _currentLimit = event.limit,
        );
        yield Loaded(invoiceList: _invoiceList);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is LoadMore) {
      yield Loading(isLoadMore: true);
      try {
        final _invoiceList =
            await _inventoryRepository.getInvoiceAccordingToDateTime(
          startDate: _currentStartDate,
          endDate: _currentEndDate,
          offset: _currentOffset = _currentOffset + _currentLimit,
          limit: _currentLimit,
        );
        if (_invoiceList.length == 0) {
          yield ReachMax();
        } else {
          yield Loaded(invoiceList: _invoiceList, isLoadMore: true);
        }
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is ButtonPressed) {
      yield Submitting();
      try {
        await _inventoryRepository.updateInvoiceStatus(event.invoiceId,
            status: event.invoiceStatus);
        yield Submitted();
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
