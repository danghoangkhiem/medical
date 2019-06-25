import 'package:medical/src/models/day_schedule_med_rep_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class DayScheduleMedRepState extends Equatable {
  DayScheduleMedRepState([List props = const []]) : super(props);
}

class DayScheduleMedRepInitial extends DayScheduleMedRepState {
  @override
  String toString() => 'AttendanceInitial';
}

class DayScheduleMedRepLoading extends DayScheduleMedRepState {
  final bool isLoadMore;

  DayScheduleMedRepLoading({this.isLoadMore = false});

  @override
  String toString() => 'AttendanceLoading';
}

class DayScheduleMedRepEmpty extends DayScheduleMedRepState {
}

class DayScheduleMedRepLoaded extends DayScheduleMedRepState {
  final DayScheduleMedRepModel dayScheduleMedRep;

  final bool isLoadMore;

  DayScheduleMedRepLoaded({@required this.dayScheduleMedRep, this.isLoadMore = false}) : super([dayScheduleMedRep, isLoadMore]);

  @override
  String toString() => 'AttendanceLoaded';
}

class DayScheduleMedRepFailure extends DayScheduleMedRepState {
  final String error;

  DayScheduleMedRepFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'AttendanceFailure { error: $error }';
}

class ReachMax extends DayScheduleMedRepState {}

class AddScheduleLoading extends DayScheduleMedRepState{}

class AddScheduleSuccess extends DayScheduleMedRepState{}
class AddScheduleFailure extends DayScheduleMedRepState{}