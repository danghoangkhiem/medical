import 'package:meta/meta.dart';

import 'api/schedule_coaching_api_provider.dart';

import 'package:medical/src/models/hours_model.dart';
import 'package:medical/src/models/schedule_coaching_model.dart';

class ScheduleCoachingRepository {
  final ScheduleCoachingApiProvider _scheduleCoachingApiProvider =
  ScheduleCoachingApiProvider();

  Future<ScheduleCoachingListModel> scheduleCoachingAccordingToDateTime({
    @required int userId,
    @required DateTime startDate,
    @required DateTime endDate,
    int offset = 0,
    int limit = 20,
  }) async {
    return await _scheduleCoachingApiProvider
        .scheduleCoachingAccordingToDateTime(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
      limit: limit,
      offset: offset,
    );
  }

  Future<ScheduleCoachingModel> createScheduleCoaching({
    @required int userId,
    @required DateTime date,
    @required int scheduleId,
    @required HoursModel hours,
  }) async {
    return await _scheduleCoachingApiProvider.createScheduleCoaching(
      userId: userId,
      date: date,
      scheduleId: scheduleId,
      hours: hours,
    );
  }

  Future<ScheduleCoachingModel> updateScheduleCoaching(
      int scheduleCoachingId, {
        @required int userId,
        @required HoursModel realHours,
        @required String description,
        @required String evaluation,
        @required String feedback,
      }) async {
    return await _scheduleCoachingApiProvider.updateScheduleCoaching(
      scheduleCoachingId,
      userId: userId,
      realHours: realHours,
      description: description,
      evaluation: evaluation,
      feedback: feedback,
    );
  }
}
