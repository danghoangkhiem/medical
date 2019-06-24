import 'package:meta/meta.dart';

@immutable
abstract class ScheduleCoachingEvent {}

class EventList extends ScheduleCoachingEvent {
  final DateTime startDate;
  final DateTime endDate;

  EventList({@required this.startDate, @required this.endDate});
}

class DaySelected extends ScheduleCoachingEvent {
  final DateTime day;

  DaySelected({@required this.day});
}

class RefreshEventList extends ScheduleCoachingEvent {}