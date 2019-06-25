import 'package:meta/meta.dart';

@immutable
abstract class ScheduleCoachingDetailEvent {}

class ButtonPressed extends ScheduleCoachingDetailEvent {
  final int id;
  final DateTime realStartTime;
  final DateTime realEndTime;
  final String description;
  final String evaluate;
  final String feedback;

  ButtonPressed(
      {@required this.id,
      this.realStartTime,
      this.realEndTime,
      this.description,
      this.evaluate,
      this.feedback});
}
