import 'package:meta/meta.dart';

@immutable
abstract class ScheduleWorkCreateEvent {}

class Schedule extends ScheduleWorkCreateEvent {
  final Map schedules;

  Schedule({@required this.schedules});
}

class DateRange extends ScheduleWorkCreateEvent {
  final DateTime startDate;
  final DateTime endDate;

  DateRange({@required this.startDate, @required this.endDate});
}