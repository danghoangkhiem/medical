import 'package:meta/meta.dart';
@immutable
abstract class ScheduleWorkDetailState {}

class Initial extends ScheduleWorkDetailState {}

class Loading extends ScheduleWorkDetailState {}

class Loaded extends ScheduleWorkDetailState {
  @override
  String toString() => 'Updated';
}

class Updated extends ScheduleWorkDetailState {
  @override
  String toString() => 'Updated';
}

class Failure extends ScheduleWorkDetailState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}