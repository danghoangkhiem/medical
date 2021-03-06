import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/day_schedule_model.dart';

class DayScheduleApiProvider extends ApiProvider {
  Future<DayScheduleListModel> getDaySchedule(
      {int offset = 0, int limit = 10, @required int userId,@required int startDate,@required int endDate}) async {
    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
      'startDate': startDate,
      'endDate': endDate,
    };
    Response _resp = await httpClient.get(
        '/users/' + userId.toString() + '/schedules',
        queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return DayScheduleListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<bool> updateSchedule(
      {int userId,
      int scheduleId,
      DateTime startTime,
      DateTime endTime,
      @required DayScheduleStatus status,
      String purpose,
      String description}) async {
    Map<String, dynamic> _requestBody = {
      'realHours': {
        'from': startTime.millisecondsSinceEpoch/1000,
        'to': endTime.millisecondsSinceEpoch/1000,
      },
      'status': status.value,
      'purpose': purpose,
      'description': description,
    };
    Response _resp = await httpClient.post(
        '/users/$userId/schedules/$scheduleId/update',
        data: _requestBody);
    if (_resp.statusCode == 200) {
      return true;
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
