import 'package:meta/meta.dart';

import 'package:medical/src/models/day_coaching_model.dart';

@immutable
abstract class DayCoachingState {}

class InitialDateCoachingState extends DayCoachingState {}

class Loading extends DayCoachingState {
  final bool isLoadMore;

  Loading({this.isLoadMore = false});
}

class Loaded extends DayCoachingState {
  final bool isLoadMore;
  final DayCoachingListModel dayCoachingList;

  Loaded({this.isLoadMore = false, @required this.dayCoachingList});
}

class Failure extends DayCoachingState {
  final String errorMessage;

  Failure({@required this.errorMessage});
}

class ReachMax extends DayCoachingState {}
