import 'package:meta/meta.dart';
import 'package:medical/src/resources/api/schedule_coaching_detail_api_provider.dart';

class ScheduleCoachingDetailRepository {

  final ScheduleCoachingDetailApiProvider _scheduleCoachingDetailApiProvider = ScheduleCoachingDetailApiProvider();

  Future<bool> updateScheduleCoachingDetail({int userId, int coachingId, DateTime realStartTime, DateTime realEndTime, String description,String evaluation, String feedback}) async {
    await Future.delayed(Duration(seconds: 1));
    return await _scheduleCoachingDetailApiProvider.updateScheduleCoachingDetail(
        userId: userId,
        coachingId: coachingId,
        startTime: realStartTime,
        endTime: realEndTime,
        description: description,
        evaluation: evaluation,
        feedback: feedback
    );
  }
}
