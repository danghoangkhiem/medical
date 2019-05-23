import 'package:meta/meta.dart';

import 'package:medical/src/models/invoice_model.dart';

@immutable
abstract class InvoiceDetailState {}

class Initial extends InvoiceDetailState {}

class Loading extends InvoiceDetailState {}

class Loaded extends InvoiceDetailState {
  final InvoiceStatus invoiceStatus;

  Loaded({@required this.invoiceStatus});
}

class Failure extends InvoiceDetailState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}