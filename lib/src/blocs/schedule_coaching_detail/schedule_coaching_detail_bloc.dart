import 'dart:async';
import 'package:bloc/bloc.dart';
import 'schedule_coaching_detail.dart';
import 'package:medical/src/resources/schedule_coaching_detail_repository.dart';
import 'package:medical/src/resources/user_repository.dart';

class ScheduleCoachingDetailBloc
    extends Bloc<ScheduleCoachingDetailEvent, ScheduleCoachingDetailState> {
  final ScheduleCoachingDetailRepository _scheduleCoachingDetailRepository = ScheduleCoachingDetailRepository();
  final UserRepository _userRepository = UserRepository();

  @override
  ScheduleCoachingDetailState get initialState => Initial();

  @override
  Stream<ScheduleCoachingDetailState> mapEventToState(
    ScheduleCoachingDetailEvent event,
  ) async* {
    if (event is ButtonPressed) {
      yield Loading();
      try {
        final user = await _userRepository.getInfoLocally();
        await _scheduleCoachingDetailRepository.updateScheduleCoachingDetail(
            userId: user.id,
            coachingId: event.id,
            realStartTime: event.realStartTime,
            realEndTime: event.realEndTime,
            description: event.description,
            evaluation: event.evaluate,
            feedback: event.feedback);
        yield Loaded();
      } catch (error) {
        yield Failure(errorMessage: error.toString());
      }
    }
  }
}
