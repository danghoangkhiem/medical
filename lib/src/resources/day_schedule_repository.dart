import 'package:meta/meta.dart';
import 'package:medical/src/models/day_schedule_model.dart';

class DayScheduleRepository {
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

  Future<bool> updateDayScheduleDetail(int id,{@required DayScheduleStatus status, DateTime realStartTime, DateTime realEndTime, String purpose, String description}) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}
