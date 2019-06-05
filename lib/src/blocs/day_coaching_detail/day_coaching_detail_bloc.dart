import 'dart:async';

import 'package:bloc/bloc.dart';

import 'day_coaching_detail.dart';

import 'package:medical/src/resources/day_coaching_repository.dart';

class DayCoachingDetailBloc
    extends Bloc<DayCoachingDetailEvent, DayCoachingDetailState> {
  final DayCoachingRepository _dayCoachingRepository = DayCoachingRepository();

  @override
  DayCoachingDetailState get initialState => Initial();

  @override
  Stream<DayCoachingDetailState> mapEventToState(
    DayCoachingDetailEvent event,
  ) async* {
    if (event is ButtonPressed) {
      yield Loading();
      try {
        await _dayCoachingRepository.updateDayCoachingDetail(
          event.id,
          realStartTime: event.realStartTime,
          realEndTime: event.realEndTime,
          description: event.description,
          evaluate: event.evaluate,
          feedback: event.feedback,
        );
        yield Loaded();
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
