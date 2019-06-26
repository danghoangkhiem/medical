import 'dart:async';

import 'package:bloc/bloc.dart';

import 'day_schedule.dart';

import 'package:medical/src/resources/day_schedule_repository.dart';
import 'package:medical/src/models/attendance_model.dart';
import 'package:medical/src/resources/user_repository.dart';
import 'package:medical/src/models/user_model.dart';

class DayScheduleBloc extends Bloc<DayScheduleEvent, DayScheduleState> {
  final DayScheduleRepository _dayScheduleRepository = DayScheduleRepository();

  final UserRepository _userRepository = UserRepository();

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
        UserModel userModel = await _userRepository.getInfo();
        int userId = 2;
        _currentOffset = event.offset;
        _currentLimit = event.limit;
        int _startDate = 1558803600;
        int _endDate = 1562518799;

        final _dayScheduleList = await _dayScheduleRepository.getDaySchedule(
            _currentOffset, _currentLimit, userId,_startDate,_endDate);
        if (_dayScheduleList.length == 0) {
          yield NoRecordsFound();
        } else {
          yield Loaded(dayScheduleList: _dayScheduleList);
        }
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
    if (event is LoadMore) {
      yield Loading(isLoadMore: true);
      try {
        UserModel userModel = await _userRepository.getInfo();
        int userId = 2;
        _currentOffset = _currentOffset + _currentLimit;
        _currentLimit = _currentLimit;
        int _startDate = 1558803600;
        int _endDate = 1562518799;
        final _dayScheduleList = await _dayScheduleRepository.getDaySchedule(
            _currentOffset, _currentLimit, userId,_startDate,_endDate);
        if (_dayScheduleList == null || _dayScheduleList.length == 0) {
          yield ReachMax();
        } else {
          yield Loaded(dayScheduleList: _dayScheduleList, isLoadMore: true);
        }
      } catch (error, stack) {
        print(stack);
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
