import 'package:meta/meta.dart';

@immutable
abstract class CustomerManageEvent {}

class CustomerManageEventFilter extends CustomerManageEvent {
  final int offset;
  final int limit;
  final String customerType;
  final String customerStatus;

  CustomerManageEventFilter({
    this.limit = 10,
    this.offset = 0,
    @required this.customerType,
    @required this.customerStatus,
  });
}

class LoadMore extends CustomerManageEvent {}

class RedButtonPressed extends CustomerManageEvent {}

class GreenButtonPressed extends CustomerManageEvent {}