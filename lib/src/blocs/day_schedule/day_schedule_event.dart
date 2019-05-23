import 'package:meta/meta.dart';

import 'package:medical/src/models/day_schedule_model.dart';

@immutable
abstract class DayScheduleEvent {}

class DayScheduleFilter extends DayScheduleEvent {
  final int offset;
  final int limit;
  final DateTime date;

  DayScheduleFilter({
    this.limit = 10,
    this.offset = 0,
    @required this.date,
  });
}

class LoadMore extends DayScheduleEvent {}