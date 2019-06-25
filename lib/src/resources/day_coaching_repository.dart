import 'package:meta/meta.dart';
import 'package:medical/src/models/day_coaching_model.dart';
import 'package:medical/src/resources/api/day_coaching_api_provider.dart';

class DayCoachingRepository {

  final DayCoachingApiProvider _dayCoachingApiProvider = DayCoachingApiProvider();

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

  Future<DayCoachingListModel> getDayCoaching(int offset, int limit,int userId, int startDate, int endDate) async {
    await Future.delayed(Duration(seconds: 1));
    return await _dayCoachingApiProvider.getDayCoaching(offset: offset, limit: limit, userId: userId,startDate: startDate, endDate: endDate);
  }

  Future<bool> updateDayCoachingDetail({int userId = 2, int coachingId, DateTime realStartTime, DateTime realEndTime, String description,String evaluation, String feedback}) async {
    await Future.delayed(Duration(seconds: 1));
    return await _dayCoachingApiProvider.updateCoaching(
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
