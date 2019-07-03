import 'dart:async';

import 'package:bloc/bloc.dart';

import 'schedule_work_create.dart';

import 'package:medical/src/resources/schedule_work_repository.dart';
import 'package:medical/src/resources/user_repository.dart';

class ScheduleWorkCreateBloc
    extends Bloc<ScheduleWorkCreateEvent, ScheduleWorkCreateState> {
  final ScheduleWorkRepository _scheduleWorkRepository =
      ScheduleWorkRepository();
  final UserRepository _userRepository = UserRepository();

  @override
  ScheduleWorkCreateState get initialState => Initial();

  @override
  Stream<ScheduleWorkCreateState> mapEventToState(
    ScheduleWorkCreateEvent event,
  ) async* {
    if (event is Schedule) {
      yield Loading();
      try {
        if (event.schedules.length == 0) {
          throw 'Không có ngày nào được lên lịch. Vui lòng kiểm tra lại';
        }
        final userInfo = await _userRepository.getInfoLocally();
        await Future.forEach(event.schedules.entries, (entry) async {
          await _scheduleWorkRepository.createScheduleWork(
            userId: userInfo.id,
            partnerId: entry.value['partnerId'],
            date: entry.value['date'],
            hours: entry.value['hours'],
          );
        });
        yield Success();
      } catch (error) {
        yield Failure(error: error.toString());
      }
    }
    if (event is DateRange) {
      yield DateRangePicked(
        startDate: event.startDate,
        endDate: event.endDate,
      );
    }
  }
}
