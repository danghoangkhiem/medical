import 'package:meta/meta.dart';

import 'package:medical/src/models/day_schedule_model.dart';

@immutable
abstract class DayScheduleDetailState {}

class Initial extends DayScheduleDetailState {}

class Loading extends DayScheduleDetailState {}

class Loaded extends DayScheduleDetailState {
  final DayScheduleStatus dayScheduleStatus;

  Loaded({@required this.dayScheduleStatus});
}

class Failure extends DayScheduleDetailState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}