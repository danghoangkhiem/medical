import 'dart:async';

import 'package:bloc/bloc.dart';

import 'day_schedule.dart';

import 'package:medical/src/resources/day_schedule_repository.dart';

class DayScheduleBloc extends Bloc<DayScheduleEvent, DayScheduleState> {
  final DayScheduleRepository _dayScheduleRepository = DayScheduleRepository();

  DateTime _date;
  int _currentOffset;
  int _currentLimit;

  @override
  DayScheduleState get initialState => InitialDateScheduleState();

  @override
  Stream<DayScheduleState> mapEventToState(
    DayScheduleEvent event,
  ) async* {
    if (event is DayScheduleFilter) {
      yield Loading();
      try {
        final _dayScheduleList =
            await _dayScheduleRepository.getDayScheduleByDateTime(
          date: _date = event.date,
          offset: _currentOffset = event.offset,
          limit: _currentLimit = event.limit,
        );
        yield Loaded(dayScheduleList: _dayScheduleList);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is LoadMore) {
      yield Loading(isLoadMore: true);
      try {
        final _dayScheduleList =
            await _dayScheduleRepository.getDayScheduleByDateTime(
          date: _date,
          offset: _currentOffset = _currentOffset + _currentLimit,
          limit: _currentLimit,
        );
        if (_dayScheduleList.length == 0) {
          yield ReachMax();
        } else {
          yield Loaded(dayScheduleList: _dayScheduleList, isLoadMore: true);
        }
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
