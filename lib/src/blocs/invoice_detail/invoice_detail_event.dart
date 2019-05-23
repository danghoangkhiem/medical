import 'package:meta/meta.dart';

import 'package:medical/src/models/invoice_model.dart';

@immutable
abstract class InvoiceDetailEvent {}

class ButtonPressed extends InvoiceDetailEvent {
  final int invoiceId;
  final InvoiceStatus invoiceStatus;

  ButtonPressed({@required this.invoiceId, @required this.invoiceStatus});
}