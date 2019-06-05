import 'dart:async';

import 'package:bloc/bloc.dart';

import 'day_coaching.dart';

import 'package:medical/src/resources/day_coaching_repository.dart';

class DayCoachingBloc extends Bloc<DayCoachingEvent, DayCoachingState> {
  final DayCoachingRepository _dayCoachingRepository = DayCoachingRepository();

  DateTime _date;
  int _currentOffset;
  int _currentLimit;

  @override
  DayCoachingState get initialState => InitialDateCoachingState();

  @override
  Stream<DayCoachingState> mapEventToState(
    DayCoachingEvent event,
  ) async* {
    if (event is DayCoachingFilter) {
      yield Loading();
      try {
        final _dayCoachingList =
            await _dayCoachingRepository.getDayCoachingByDateTime(
          date: _date = event.date,
          offset: _currentOffset = event.offset,
          limit: _currentLimit = event.limit,
        );
        yield Loaded(dayCoachingList: _dayCoachingList);
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is LoadMore) {
      yield Loading(isLoadMore: true);
      try {
        final _dayCoachingList =
            await _dayCoachingRepository.getDayCoachingByDateTime(
          date: _date,
          offset: _currentOffset = _currentOffset + _currentLimit,
          limit: _currentLimit,
        );
        if (_dayCoachingList.length == 0) {
          yield ReachMax();
        } else {
          yield Loaded(dayCoachingList: _dayCoachingList, isLoadMore: true);
        }
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
