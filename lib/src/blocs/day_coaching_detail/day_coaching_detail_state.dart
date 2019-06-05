import 'package:meta/meta.dart';

import 'package:medical/src/models/day_coaching_model.dart';

@immutable
abstract class DayCoachingDetailState {}

class Initial extends DayCoachingDetailState {}

class Loading extends DayCoachingDetailState {}

class Loaded extends DayCoachingDetailState {
  @override
  String toString() => 'Loaded';
}

class Failure extends DayCoachingDetailState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}