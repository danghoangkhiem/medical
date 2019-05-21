import 'package:medical/src/models/attendances_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AttendanceState extends Equatable {
  AttendanceState([List props = const []]) : super(props);
}

class AttendanceInitial extends AttendanceState {
  @override
  String toString() => 'AttendanceInitial';
}

class AttendanceLoading extends AttendanceState {
  @override
  String toString() => 'AttendanceLoading';
}

class AttendanceLoaded extends AttendanceState {
  final AttendancesModel attendance;

  bool isLoadingMore;

  AttendanceLoaded({@required this.attendance, this.isLoadingMore = false}) : super([attendance, isLoadingMore]);

  @override
  String toString() => 'AttendanceLoaded';
}

class AttendanceFailure extends AttendanceState {
  final String error;

  AttendanceFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'AttendanceFailure { error: $error }';
}