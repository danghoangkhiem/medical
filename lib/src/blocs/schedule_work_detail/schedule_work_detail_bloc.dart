import 'dart:async';
import 'package:bloc/bloc.dart';
import 'schedule_work_detail.dart';

import 'package:medical/src/resources/schedule_work_detail_repository.dart';
import 'package:medical/src/resources/user_repository.dart';

class ScheduleWorkDetailBloc
    extends Bloc<ScheduleWorkDetailEvent, ScheduleWorkDetailState> {
  final ScheduleWorkDetailRepository _scheduleWorkDetailRepository = ScheduleWorkDetailRepository();
  final UserRepository _userRepository = UserRepository();

  @override
  ScheduleWorkDetailState get initialState => Initial();

  @override
  Stream<ScheduleWorkDetailState> mapEventToState(
      ScheduleWorkDetailEvent event,
  ) async* {
    if (event is ButtonPressed) {
      yield Loading();
      try {
        final user = await _userRepository.getInfoLocally();
        await _scheduleWorkDetailRepository.updateScheduleWorkDetail(
          userId: user.id,
          scheduleId: event.scheduleId,
          realStartTime: event.realStartTime,
          realEndTime: event.realEndTime,
          purpose: event.purpose,
          status: event.status,
          description: event.description
        );
        yield Loaded();
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
