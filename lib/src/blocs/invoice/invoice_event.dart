import 'package:meta/meta.dart';

import 'package:medical/src/models/invoice_model.dart';

@immutable
abstract class InvoiceEvent {}

class InvoiceFilter extends InvoiceEvent {
  final int offset;
  final int limit;
  final DateTime startDate;
  final DateTime endDate;

  InvoiceFilter({
    this.limit = 10,
    this.offset = 0,
    @required this.startDate,
    @required this.endDate,
  });
}

class LoadMore extends InvoiceEvent {}

class ButtonPressed extends InvoiceEvent {
  final int invoiceId;
  final InvoiceStatus invoiceStatus;

  ButtonPressed({@required this.invoiceId, @required this.invoiceStatus});
}