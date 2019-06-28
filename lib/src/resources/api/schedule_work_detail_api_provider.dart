import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/schedule_work_model.dart';

class ScheduleWorkDetailApiProvider extends ApiProvider {

  Future<bool> updateScheduleDetail(
      {int userId,
      int scheduleId,
      DateTime startTime,
      DateTime endTime,
      @required ScheduleWorkType status,
      String purpose,
      String description}) async {
    Map<String, dynamic> _requestBody = {
      'realHours': {
        'from': startTime.millisecondsSinceEpoch ~/ 1000,
        'to': endTime.millisecondsSinceEpoch ~/ 1000,
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
