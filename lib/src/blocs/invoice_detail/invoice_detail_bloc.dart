import 'dart:async';

import 'package:bloc/bloc.dart';

import 'invoice_detail.dart';

import 'package:medical/src/resources/invoice_repository.dart';

class InvoiceDetailBloc extends Bloc<InvoiceDetailEvent, InvoiceDetailState> {
  final InvoiceRepository _inventoryRepository = InvoiceRepository();

  @override
  InvoiceDetailState get initialState => Initial();

  @override
  Stream<InvoiceDetailState> mapEventToState(
    InvoiceDetailEvent event,
  ) async* {
    if (event is ButtonPressed) {
      yield Loading();
      try {
        await _inventoryRepository.updateInvoiceStatus(event.invoiceId,
            status: event.invoiceStatus);
        yield Loaded(invoiceStatus: event.invoiceStatus);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
