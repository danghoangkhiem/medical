import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ManageAreaEvent extends Equatable {
  ManageAreaEvent([List props = const []]) : super(props);
}

class GetManageArea extends ManageAreaEvent {
  final int offset;
  final int limit;
  final DateTime date;

  GetManageArea({
    this.offset = 0,
    this.limit = 10,
    @required this.date,
  }) : super([offset, limit, date]);

}

class LoadMore extends ManageAreaEvent {}

