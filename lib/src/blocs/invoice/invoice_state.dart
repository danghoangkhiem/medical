import 'package:meta/meta.dart';

import 'package:medical/src/models/invoice_model.dart';

@immutable
abstract class InvoiceState {}

class InitialInvoiceState extends InvoiceState {}

class Loading extends InvoiceState {
  final bool isLoadMore;

  Loading({this.isLoadMore = false});
}

class Loaded extends InvoiceState {
  final bool isLoadMore;
  final InvoiceListModel invoiceList;

  Loaded({this.isLoadMore = false, @required this.invoiceList});
}

class Failure extends InvoiceState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}

class ReachMax extends InvoiceState {}