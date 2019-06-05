import 'package:meta/meta.dart';

import 'package:medical/src/models/day_coaching_model.dart';

@immutable
abstract class DayCoachingDetailEvent {}

class ButtonPressed extends DayCoachingDetailEvent {
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
