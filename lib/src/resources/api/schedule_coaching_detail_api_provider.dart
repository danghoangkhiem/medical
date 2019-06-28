import 'package:meta/meta.dart';
import 'api_provider.dart';
import 'api_response_error.dart';

class ScheduleCoachingDetailApiProvider extends ApiProvider {
  Future<bool> updateScheduleCoachingDetail(
      {int userId,
        int coachingId,
        DateTime startTime,
        DateTime endTime,
        String description,
        String evaluation,
        String feedback,}) async {
    Map<String, dynamic> _requestBody = {
      'realHours': {
        'from': startTime.millisecondsSinceEpoch ~/ 1000,
        'to': endTime.millisecondsSinceEpoch ~/1000,
      },
      'description': description,
      'evaluation': evaluation,
      'feedback': feedback,
    };
    Response _resp = await httpClient.post(
        '/users/$userId/schedules-coaching/$coachingId/update',
        data: _requestBody);
    if (_resp.statusCode == 200) {
      return true;
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
