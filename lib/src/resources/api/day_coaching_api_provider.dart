import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/day_coaching_model.dart';

class DayCoachingApiProvider extends ApiProvider {
  Future<DayCoachingListModel> getDayCoaching(
      {int offset = 0, int limit = 10, @required int userId, int startDate, int endDate}) async {
    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
      'startDate': startDate,
      'endDate': endDate,
    };
    Response _resp = await httpClient.get(
        '/users/$userId/schedules-coaching',
        queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return DayCoachingListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<bool> updateCoaching(
      {int userId,
        int coachingId,
        DateTime startTime,
        DateTime endTime,
        String description,
        String evaluation,
        String feedback,}) async {
    Map<String, dynamic> _requestBody = {
      'realHours': {
        'from': startTime.millisecondsSinceEpoch/1000,
        'to': endTime.millisecondsSinceEpoch/1000,
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
