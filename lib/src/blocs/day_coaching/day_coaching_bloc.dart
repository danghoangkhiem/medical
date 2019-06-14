import 'dart:async';

import 'package:bloc/bloc.dart';

import 'day_coaching.dart';

import 'package:medical/src/resources/day_coaching_repository.dart';
import 'package:medical/src/models/attendance_model.dart';
import 'package:medical/src/resources/user_repository.dart';
import 'package:medical/src/models/user_model.dart';

class DayCoachingBloc extends Bloc<DayCoachingEvent, DayCoachingState> {
  final DayCoachingRepository _dayCoachingRepository = DayCoachingRepository();

  final UserRepository _userRepository = UserRepository();

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
        AttendanceModel attendanceModel =
            await _userRepository.getAttendanceLastTimeLocally();
        UserModel userModel = await _userRepository.getInfo();
        int userId = 5;
        int timeIn = attendanceModel.timeIn.millisecondsSinceEpoch ~/ 1000;
        _currentOffset = event.offset;
        _currentLimit = event.limit;
        final _dayCoachingList = await _dayCoachingRepository.getDayCoaching(
            _currentOffset, _currentLimit, userId);
        print(_dayCoachingList);
        if (_dayCoachingList.length == 0) {
          yield NoRecordsFound();
        } else {
          yield Loaded(dayCoachingList: _dayCoachingList);
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
        final _dayCoachingList = await _dayCoachingRepository.getDayCoaching(
            _currentOffset, _currentLimit, userId);
        if (_dayCoachingList == null || _dayCoachingList.length == 0) {
          yield ReachMax();
        } else {
          yield Loaded(dayCoachingList: _dayCoachingList, isLoadMore: true);
        }
      } catch (error, stack) {
        print(stack);
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
