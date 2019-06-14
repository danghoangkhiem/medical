import 'package:meta/meta.dart';

import 'package:medical/src/models/day_schedule_model.dart';

@immutable
abstract class DayScheduleState {}

class InitialDateScheduleState extends DayScheduleState {}

class Loading extends DayScheduleState {
  final bool isLoadMore;

  Loading({this.isLoadMore = false});
}

class Loaded extends DayScheduleState {
  final bool isLoadMore;
  final DayScheduleListModel dayScheduleList;

  Loaded({this.isLoadMore = false, @required this.dayScheduleList});
}

class Failure extends DayScheduleState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}

class ReachMax extends DayScheduleState {}

class NoRecordsFound extends DayScheduleState {}
