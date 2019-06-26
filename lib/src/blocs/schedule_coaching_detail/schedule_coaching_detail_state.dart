import 'package:meta/meta.dart';

@immutable
abstract class ScheduleCoachingDetailState {}

class Initial extends ScheduleCoachingDetailState {}

class Loading extends ScheduleCoachingDetailState {}

class Loaded extends ScheduleCoachingDetailState {
  @override
  String toString() => 'Loaded';
}

class Failure extends ScheduleCoachingDetailState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}