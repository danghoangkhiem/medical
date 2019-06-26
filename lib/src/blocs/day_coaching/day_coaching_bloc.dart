import 'dart:async';

import 'package:bloc/bloc.dart';

import 'day_coaching.dart';

import 'package:medical/src/resources/day_coaching_repository.dart';
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
        UserModel userModel = await _userRepository.getInfo();
        int userId = 2;
        _currentOffset = event.offset;
        _currentLimit = event.limit;
        int _startDate = 1558062170;
        int _endDate = 1562518799;
        final _dayCoachingList = await _dayCoachingRepository.getDayCoaching(
            _currentOffset, _currentLimit, userId,_startDate,_endDate);
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
        UserModel userModel = await _userRepository.getInfo();
        int userId = 2;
        _currentOffset = _currentOffset + _currentLimit;
        _currentLimit = _currentLimit;
        int _startDate = 1558062170;
        int _endDate = 1562518799;
        final _dayCoachingList = await _dayCoachingRepository.getDayCoaching(
            _currentOffset, _currentLimit, userId,_startDate,_endDate);
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
