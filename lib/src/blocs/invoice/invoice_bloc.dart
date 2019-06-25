import 'dart:async';

import 'package:bloc/bloc.dart';

import 'invoice.dart';

import 'package:medical/src/resources/invoice_repository.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final InvoiceRepository _invoiceRepository = InvoiceRepository();

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
    if (event is RefreshFilterResult) {
      dispatch(InvoiceFilter(
          startDate: _currentStartDate,
          endDate: _currentEndDate,
          offset: 0,
          limit: _currentLimit));
    }
    if (event is InvoiceFilter) {
      yield Loading();
      try {
        if (event.startDate == null || event.endDate == null) {
          throw 'Phải chọn thời gian';
        }
        final _invoiceList =
            await _invoiceRepository.getInvoiceAccordingToDateTime(
          startDate: _currentStartDate = event.startDate,
          endDate: _currentEndDate = event.endDate,
          offset: _currentOffset = event.offset,
          limit: _currentLimit = event.limit,
        );
        if (_invoiceList.length == 0) {
          yield NoRecordsFound();
        } else {
          yield Loaded(invoiceList: _invoiceList);
        }
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is LoadMore) {
      yield Loading(isLoadMore: true);
      try {
        final _invoiceList =
            await _invoiceRepository.getInvoiceAccordingToDateTime(
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
  }
}
