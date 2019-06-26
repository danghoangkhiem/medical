import 'package:meta/meta.dart';
import 'package:medical/src/models/day_schedule_model.dart';
import 'package:medical/src/resources/api/day_schedule_api_provider.dart';

class DayScheduleRepository {
  final DayScheduleApiProvider _dayScheduleApiProvider = DayScheduleApiProvider();

  Future<DayScheduleListModel> getDayScheduleByDateTime({
    int offset = 10,
    int limit = 0,
    @required DateTime date,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return DayScheduleListModel.fromJson(List(10).map((item) {
      return {
        "id": 1,
        "startTime": 1558547173438,
        "endTime": 1558547173438,
        "position": "BS",
        "doctorName": "Nguyễn Văn A",
        "addressType": "BV",
        "addressName": "Chợ Rẫy",
        "realStartTime": 1558547173438,
        "realEndTime": 1558547173438,
        "status": "met",
        "purpose": "OK Pur",
        "description": "OK DES",
      };
    }).toList());
  }

  Future<DayScheduleListModel> getDaySchedule(int offset, int limit,int userId,int startDate, int endDate) async {
    await Future.delayed(Duration(seconds: 1));
    return await _dayScheduleApiProvider.getDaySchedule(offset: offset, limit: limit, userId: userId,startDate: startDate,endDate: endDate);
  }

  Future<bool> updateDayScheduleDetail({int userId = 5, int scheduleId,@required DayScheduleStatus status, DateTime realStartTime, DateTime realEndTime, String purpose, String description}) async {
    await Future.delayed(Duration(seconds: 1));
    return await _dayScheduleApiProvider.updateSchedule(
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
