import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DayScheduleMedRepEvent extends Equatable {
  DayScheduleMedRepEvent([List props = const []]) : super(props);
}

class GetDayScheduleMedRep extends DayScheduleMedRepEvent {
  final int offset;
  final int limit;
  final DateTime date;
  final int userId;

  GetDayScheduleMedRep({
    this.offset = 0,
    this.limit = 20,
    @required this.date,
    @required this.userId
  }) : super([offset, limit, date, userId]);

}

class LoadMore extends DayScheduleMedRepEvent {}

class AddSchedule extends DayScheduleMedRepEvent{
  final int userId;
  final DateTime date;
  final int scheduleId;
  final DateTime from;
  final DateTime to;

  AddSchedule({this.userId,this.date, this.scheduleId, this.from, this.to}) :super ([userId,date, scheduleId, from, to]);


}