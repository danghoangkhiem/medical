import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AttendanceEvent extends Equatable {
  AttendanceEvent([List props = const []]) : super(props);
}

class GetAttendance extends AttendanceEvent {
  final int offset;
  final int limit;
  final DateTime startDate;
  final DateTime endDate;

  GetAttendance({
    this.offset = 0,
    this.limit = 10,
    @required this.startDate,
    @required this.endDate
  }) : super([offset, limit, startDate, endDate]);

}

class LoadMore extends AttendanceEvent {}

