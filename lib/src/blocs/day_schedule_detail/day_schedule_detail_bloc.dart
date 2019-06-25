import 'dart:async';

import 'package:bloc/bloc.dart';

import 'day_schedule_detail.dart';

import 'package:medical/src/resources/day_schedule_repository.dart';

class DayScheduleDetailBloc
    extends Bloc<DayScheduleDetailEvent, DayScheduleDetailState> {
  final DayScheduleRepository _dayScheduleRepository = DayScheduleRepository();

  @override
  DayScheduleDetailState get initialState => Initial();

  @override
  Stream<DayScheduleDetailState> mapEventToState(
    DayScheduleDetailEvent event,
  ) async* {
    if (event is ButtonPressed) {
      yield Loading();
      try {
        await _dayScheduleRepository.updateDayScheduleDetail(
          userId: 2,
          scheduleId: event.scheduleId,
          realStartTime: event.realStartTime,
          realEndTime: event.realEndTime,
          purpose: event.purpose,
          status: event.dayScheduleStatus,
          description: event.description
        );
        yield Loaded();
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
