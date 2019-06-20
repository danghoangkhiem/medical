import 'package:medical/src/models/day_schedule_med_rep_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ManageAreaState extends Equatable {
  ManageAreaState([List props = const []]) : super(props);
}

class ManageAreaInitial extends ManageAreaState {
  @override
  String toString() => 'AttendanceInitial';
}

class ManageAreaLoading extends ManageAreaState {
  final bool isLoadMore;

  ManageAreaLoading({this.isLoadMore = false});

  @override
  String toString() => 'AttendanceLoading';
}

class ManageAreaEmpty extends ManageAreaState {
}

class ManageAreaLoaded extends ManageAreaState {
  final DayScheduleMedRepModel manageArea;

  final bool isLoadMore;

  ManageAreaLoaded({@required this.manageArea, this.isLoadMore = false}) : super([manageArea, isLoadMore]);

  @override
  String toString() => 'AttendanceLoaded';
}

class ManageAreaFailure extends ManageAreaState {
  final String error;

  ManageAreaFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'AttendanceFailure { error: $error }';
}

class ReachMax extends ManageAreaState {}