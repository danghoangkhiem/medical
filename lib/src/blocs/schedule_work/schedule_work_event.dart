import 'package:meta/meta.dart';

@immutable
abstract class ScheduleWorkEvent {}

class EventList extends ScheduleWorkEvent {
  final DateTime startDate;
  final DateTime endDate;

  EventList({@required this.startDate, @required this.endDate});
}

class DaySelected extends ScheduleWorkEvent {
  final DateTime day;

  DaySelected({@required this.day});
}