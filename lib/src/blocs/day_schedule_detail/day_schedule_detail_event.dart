import 'package:meta/meta.dart';

import 'package:medical/src/models/day_schedule_model.dart';

@immutable
abstract class DayScheduleDetailEvent {}

class ButtonPressed extends DayScheduleDetailEvent {
  final int id;
  final DateTime realStartTime;
  final DateTime realEndTime;
  final DayScheduleStatus dayScheduleStatus;
  final String purpose;
  final String description;

  ButtonPressed({@required this.id, @required this.dayScheduleStatus, this.realStartTime, this.realEndTime,this.purpose, this.description});
}