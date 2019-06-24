import 'package:meta/meta.dart';

@immutable
abstract class ScheduleWorkCreateState {}

class Initial extends ScheduleWorkCreateState {}

class Loading extends ScheduleWorkCreateState {}

class Success extends ScheduleWorkCreateState {}

class Failure extends ScheduleWorkCreateState {
  final String error;

  Failure({@required this.error});
}

class DateRangePicked extends ScheduleWorkCreateState {
  final DateTime startDate;
  final DateTime endDate;

  DateRangePicked({@required this.startDate, @required this.endDate});
}