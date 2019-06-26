import 'package:meta/meta.dart';

import 'package:medical/src/models/schedule_work_model.dart';

@immutable
abstract class ScheduleWorkDetailEvent {}

class ButtonPressed extends ScheduleWorkDetailEvent {
  final int scheduleId;
  final DateTime realStartTime;
  final DateTime realEndTime;
  final ScheduleWorkType status;
  final String purpose;
  final String description;

  ButtonPressed({@required this.scheduleId, @required this.status, this.realStartTime, this.realEndTime,this.purpose, this.description});
}