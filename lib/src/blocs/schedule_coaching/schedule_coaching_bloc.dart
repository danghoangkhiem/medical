import 'dart:async';

import 'package:bloc/bloc.dart';

import 'schedule_coaching.dart';

import 'package:medical/src/resources/schedule_coaching_repository.dart';
import 'package:medical/src/resources/user_repository.dart';

import 'package:medical/src/models/schedule_coaching_model.dart';

class ScheduleCoachingBloc
    extends Bloc<ScheduleCoachingEvent, ScheduleCoachingState> {
  final ScheduleCoachingRepository _scheduleCoachingRepository =
      ScheduleCoachingRepository();
  final UserRepository _userRepository = UserRepository();

  DateTime _lastStartDate;
  DateTime _lastEndDate;

  @override
  ScheduleCoachingState get initialState =>
      ScheduleCoachingState.uninitialized();

  @override
  Stream<ScheduleCoachingState> mapEventToState(
    ScheduleCoachingEvent event,
  ) async* {
    if (event is RefreshEventList) {
      dispatch(EventList(startDate: _lastStartDate, endDate: _lastEndDate));
    }
    if (event is EventList) {
      yield ScheduleCoachingState.loading();
      try {
        var _userInfo = await _userRepository.getInfoLocally();
        var _limit = 20;
        var _result;
        var _schedules = ScheduleCoachingListModel.fromJson([]);
        do {
          _result = await _scheduleCoachingRepository
              .scheduleCoachingAccordingToDateTime(
            userId: _userInfo.id,
            startDate: _lastStartDate = event.startDate,
            endDate: _lastEndDate = event.endDate,
            offset: _schedules.length,
            limit: _limit,
          );
          _schedules.addAll(_result);
        } while (_result != null && _result.length == _limit);
        yield ScheduleCoachingState.loaded(schedules: _schedules);
      } catch (error) {
        yield ScheduleCoachingState.failure(
          isInitialized: currentState.isInitialized,
          errorMessage: error.toString(),
        );
      }
    }
    if (event is DaySelected) {
      yield ScheduleCoachingState.selectedDay(
          day: event.day, schedules: currentState.schedules);
    }
  }
}
