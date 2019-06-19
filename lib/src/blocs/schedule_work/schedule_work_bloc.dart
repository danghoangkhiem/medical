import 'dart:async';

import 'package:bloc/bloc.dart';

import 'schedule_work.dart';

import 'package:medical/src/resources/schedule_work_repository.dart';
import 'package:medical/src/resources/user_repository.dart';

import 'package:medical/src/models/schedule_work_model.dart';

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
        var _limit = 20;
        var _result;
        var _schedules = ScheduleWorkListModel.fromJson([]);
        do {
          _result =
              await _scheduleWorkRepository.scheduleWorkAccordingToDateTime(
            userId: _userInfo.id,
            startDate: event.startDate,
            endDate: event.endDate,
            limit: _limit,
          );
          _schedules.addAll(_result);
        } while (_result != null && _result.length == _limit);
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
