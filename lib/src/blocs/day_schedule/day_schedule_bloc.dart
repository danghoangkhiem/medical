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
        AttendanceModel attendanceModel =
            await _userRepository.getAttendanceLastTimeLocally();
        UserModel userModel = await _userRepository.getInfo();
        int userId = 5;
        int timeIn = attendanceModel.timeIn.millisecondsSinceEpoch ~/ 1000;
        _currentOffset = event.offset;
        _currentLimit = event.limit;
        final _dayScheduleList = await _dayScheduleRepository.getDaySchedule(
            _currentOffset, _currentLimit, userId);
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
        AttendanceModel attendanceModel =
            await _userRepository.getAttendanceLastTimeLocally();
        UserModel userModel = await _userRepository.getInfo();
        int userId = 5;
        int timeIn = attendanceModel.timeIn.millisecondsSinceEpoch ~/ 1000;
        _currentOffset = _currentOffset + _currentLimit;
        _currentLimit = _currentLimit;
        final _dayScheduleList = await _dayScheduleRepository.getDaySchedule(
            _currentOffset, _currentLimit, userId);
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
