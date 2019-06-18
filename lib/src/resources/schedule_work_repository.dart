import 'package:meta/meta.dart';

import 'api/schedule_work_api_provider.dart';

import 'package:medical/src/models/hours_model.dart';
import 'package:medical/src/models/schedule_work_model.dart';

class ScheduleWorkRepository {
  final ScheduleWorkApiProvider _scheduleWorkApiProvider =
      ScheduleWorkApiProvider();

  Future<ScheduleWorkListModel> scheduleWorkAccordingToDateTime({
    @required int userId,
    @required DateTime startDate,
    @required DateTime endDate,
    int offset = 0,
    int limit = 20,
  }) async {
    return await _scheduleWorkApiProvider.scheduleWorkAccordingToDateTime(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
      limit: limit,
      offset: offset,
    );
  }

  Future<ScheduleWorkModel> createScheduleWork({
    @required int userId,
    @required int partnerId,
    @required DateTime date,
    @required HoursModel hours,
  }) async {
    return await _scheduleWorkApiProvider.createScheduleWork(
      userId: userId,
      partnerId: partnerId,
      date: date,
      hours: hours,
    );
  }

  Future<ScheduleWorkModel> updateScheduleWork(
    int scheduleId, {
    @required int userId,
    @required HoursModel realHours,
    @required ScheduleWorkType status,
    @required String purpose,
    @required String description,
  }) async {
    return await _scheduleWorkApiProvider.updateScheduleWork(
      scheduleId,
      userId: userId,
      realHours: realHours,
      status: status,
      purpose: purpose,
      description: description,
    );
  }
}
