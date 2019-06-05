import 'package:meta/meta.dart';
import 'package:medical/src/models/day_coaching_model.dart';

class DayCoachingRepository {
  Future<DayCoachingListModel> getDayCoachingByDateTime({
    int offset = 10,
    int limit = 0,
    @required DateTime date,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return DayCoachingListModel.fromJson(List(10).map((item) {
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
        'description': "DES OK",
        'evaluate': "EVA OK",
        'feedback': "Fee OK",
      };
    }).toList());
  }

  Future<bool> updateDayCoachingDetail(int id,{DateTime realStartTime, DateTime realEndTime, String description, String evaluate, String feedback}) async {
    await Future.delayed(Duration(seconds: 1));
    print("Đã tới repo");
    print(id);
    print(evaluate);
    return true;
  }
}
