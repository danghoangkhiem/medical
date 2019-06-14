import 'dart:async';

import 'package:bloc/bloc.dart';

import 'schedule_work.dart';

import 'package:medical/src/resources/schedule_work_repository.dart';
import 'package:medical/src/resources/user_repository.dart';

class ScheduleWorkBloc extends Bloc<ScheduleWorkEvent, ScheduleWorkState> {
  final ScheduleWorkRepository _scheduleWorkRepository =
      ScheduleWorkRepository();
  final UserRepository _userRepository = UserRepository();

  @override
  ScheduleWorkState get initialState => ScheduleWorkState.uninitialized();

  @override
  Stream<ScheduleWorkState> mapEventToState(
    ScheduleWorkEvent event,
  ) async* {
    if (event is EventList) {
      yield ScheduleWorkState.loading();
      try {
        var _userInfo = await _userRepository.getInfoLocally();
        var _schedules =
            await _scheduleWorkRepository.scheduleWorkAccordingToDateTime(
          userId: _userInfo.id,
          startDate: event.startDate,
          endDate: event.endDate,
        );
        yield ScheduleWorkState.loaded(schedules: _schedules);
      } catch (error) {
        yield ScheduleWorkState.failure(
          isInitialized: currentState.isInitialized,
          errorMessage: error.toString(),
        );
      }
    }
    if (event is DaySelected) {
      yield ScheduleWorkState.selectedDay(
          day: event.day, schedules: currentState.schedules);
    }
  }
}
