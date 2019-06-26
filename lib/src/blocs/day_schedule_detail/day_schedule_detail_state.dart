import 'package:meta/meta.dart';


@immutable
abstract class DayScheduleDetailState {}

class Initial extends DayScheduleDetailState {}

class Loading extends DayScheduleDetailState {}

class Loaded extends DayScheduleDetailState {
  @override
  String toString() => 'Updated';
}

class Updated extends DayScheduleDetailState {
  @override
  String toString() => 'Updated';
}

class Failure extends DayScheduleDetailState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}