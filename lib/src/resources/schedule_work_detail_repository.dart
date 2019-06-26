import 'package:meta/meta.dart';
import 'package:medical/src/models/schedule_work_model.dart';
import 'package:medical/src/resources/api/schedule_work_detail_api_provider.dart';

class ScheduleWorkDetailRepository {
  final ScheduleWorkDetailApiProvider _scheduleWorkDetailApiProvider = ScheduleWorkDetailApiProvider();

  Future<bool> updateScheduleWorkDetail({int userId = 5, int scheduleId,@required ScheduleWorkType status, DateTime realStartTime, DateTime realEndTime, String purpose, String description}) async {
    await Future.delayed(Duration(seconds: 1));
    return await _scheduleWorkDetailApiProvider.updateScheduleDetail(
      userId: userId,
      scheduleId: scheduleId,
      startTime: realStartTime,
      endTime: realEndTime,
      purpose: purpose,
      status: status,
      description: description
    );
  }
}
