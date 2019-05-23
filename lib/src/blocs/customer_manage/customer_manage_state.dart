import 'package:meta/meta.dart';

import 'package:medical/src/models/customer_manage_model.dart';

@immutable
abstract class CustomerManageState {}

class InitialCustomerManageState extends CustomerManageState {}

class Loading extends CustomerManageState {
  final bool isLoadMore;

  Loading({this.isLoadMore = false});
}

class Loaded extends CustomerManageState {
  final bool isLoadMore;
  final CustomerManagerListModel customerManagerList;

  Loaded({this.isLoadMore = false, @required this.customerManagerList});
}

class Failure extends CustomerManageState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}

class ReachMax extends CustomerManageState {}