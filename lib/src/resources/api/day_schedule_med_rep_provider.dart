import 'package:medical/src/models/day_schedule_med_rep_model.dart';
import 'package:medical/src/models/schedule_coaching_model.dart';
import 'package:medical/src/resources/api/api_response_error.dart';
import 'package:meta/meta.dart';
import 'api_provider.dart';

class DayScheduleMedRepProvider extends ApiProvider {

  Future<ScheduleCoachingModel> createScheduleCoaching({
    @required int userId,
    @required DateTime date,
    @required int scheduleId,
    @required DateTime from,
    @required DateTime to
  }) async {
    Map<String, dynamic> _requestBody = {
      'date': date.millisecondsSinceEpoch ~/ 1000,
      'scheduleId': scheduleId,
      'hours': {
        "from": from == null ? null : from.millisecondsSinceEpoch ~/ 1000,
        "to" : to == null ? null : to.millisecondsSinceEpoch ~/ 1000
      },
    };

    print("la la la");
    print(userId);
    print(scheduleId);
    print(date);
    print(from);
    print(to);


    Response _resp = await httpClient.post('/users/$userId/schedules-coaching',
        data: _requestBody);
    if (_resp.statusCode == 200) {
      return ScheduleCoachingModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }



  Future<DayScheduleMedRepModel> getDayScheduleMedRep(
      {int offset = 0,
      int limit = 20,
      @required DateTime date,
      @required int userId}) async {
    await Future.delayed(Duration(milliseconds: 200));

    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
      'startDate': DateTime(date.year, date.month, date.day, 00, 00, 00).millisecondsSinceEpoch ~/ 1000,
      'endDate': DateTime(date.year, date.month, date.day, 00, 00, 00).millisecondsSinceEpoch ~/ 1000

//      'startDate': DateTime(date.year, date.month, date.day, 00, 00, 00)
//              .millisecondsSinceEpoch ~/
//          1000,
//      'endDate': DateTime(date.year, date.month, date.day, 00, 00, 00)
//              .millisecondsSinceEpoch ~/
//          1000
    };

    //truyền tham số mặc định
    Response _resp = await httpClient.get('/users/$userId/schedules',
        queryParameters: _queryParameters);

    if (_resp.statusCode == 200) {
      return DayScheduleMedRepModel.fromJson(_resp.data["data"]);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));

//    return DayScheduleMedRepModel.fromJson([
//      {
//        "id": 2,
//        "startTime": 1559927049446,
//        "endTime": 1559927049746,
//        "realStartTime": null,
//        "realEndTime": null,
//        "doctorName": "Nhật Thuần Phong 2",
//        "addressType": "benh vien",
//        "addressName": "binh thah",
//        "status": 1,
//        "targetBefore": "",
//        "targetAfter": ""
//      },
//      {
//        "id": 3,
//        "startTime": 1559927049446,
//        "endTime": 1559927049746,
//        "realStartTime": null,
//        "realEndTime": null,
//        "doctorName": "Nhật Thuần Phong 3",
//        "addressType": "benh vien",
//        "addressName": "binh thah",
//        "status": 1,
//        "targetBefore": "",
//        "targetAfter": ""
//      }
//    ]);
  }
}
