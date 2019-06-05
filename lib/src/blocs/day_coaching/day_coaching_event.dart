import 'package:meta/meta.dart';

@immutable
abstract class DayCoachingEvent {}

class DayCoachingFilter extends DayCoachingEvent {
  final int offset;
  final int limit;
  final DateTime date;

  DayCoachingFilter({
    this.limit = 10,
    this.offset = 0,
    @required this.date,
  });
}

class LoadMore extends DayCoachingEvent {}