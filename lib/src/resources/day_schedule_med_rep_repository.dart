import 'package:medical/src/models/day_schedule_med_rep_model.dart';
import 'package:medical/src/models/hours_model.dart';
import 'package:medical/src/models/schedule_coaching_model.dart';
import 'package:medical/src/resources/api/day_schedule_med_rep_provider.dart';
import 'package:meta/meta.dart';

class DayScheduleMedRepRepository {
  final DayScheduleMedRepProvider _dayScheduleMedRepProvider =
      DayScheduleMedRepProvider();

  Future<DayScheduleMedRepModel> getDayScheduleMedRep(
      {DateTime date, int offset, int limit, int userId}) async {
    return await _dayScheduleMedRepProvider.getDayScheduleMedRep(
        offset: offset, limit: limit, date: date, userId: userId);
  }

  Future<ScheduleCoachingModel> createScheduleCoaching(
  {@required int userId,
    @required DateTime date,
    @required int scheduleId,
    @required DateTime from,
    @required DateTime to
  }
  ) async {
    return await _dayScheduleMedRepProvider.createScheduleCoaching(
      userId: userId,
      date: date,
      scheduleId: scheduleId,
      from: from,
      to: to
    );
  }

}
