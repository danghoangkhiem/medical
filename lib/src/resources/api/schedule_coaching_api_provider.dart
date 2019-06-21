import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/hours_model.dart';
import 'package:medical/src/models/schedule_coaching_model.dart';

class ScheduleCoachingApiProvider extends ApiProvider {
  Future<ScheduleCoachingListModel> scheduleCoachingAccordingToDateTime({
    @required int userId,
    @required DateTime startDate,
    @required DateTime endDate,
    int offset = 0,
    int limit = 20,
  }) async {
    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
      'startDate':
          DateTime(startDate.year, startDate.month, startDate.day, 00, 00, 00)
                  .millisecondsSinceEpoch ~/
              1000,
      'endDate': DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59)
              .millisecondsSinceEpoch ~/
          1000,
    };
    Response _resp = await httpClient.get('/users/$userId/schedules-coaching',
        queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return ScheduleCoachingListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<ScheduleCoachingModel> createScheduleCoaching({
    @required int userId,
    @required DateTime date,
    @required int scheduleId,
    @required HoursModel hours,
  }) async {
    Map<String, dynamic> _requestBody = {
      'date': date.millisecondsSinceEpoch ~/ 1000,
      'scheduleId': scheduleId,
      'hours': hours.toJson(),
    };
    Response _resp = await httpClient.post('/users/$userId/schedules-coaching',
        data: _requestBody);
    if (_resp.statusCode == 200) {
      return ScheduleCoachingModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<ScheduleCoachingModel> updateScheduleCoaching(
    int scheduleCoachingId, {
    @required int userId,
    @required HoursModel realHours,
    @required String description,
    @required String evaluation,
    @required String feedback,
  }) async {
    Map<String, dynamic> _requestBody = {
      'realHours': realHours.toJson(),
      'description': description,
      'description': evaluation,
      'description': feedback,
    };
    Response _resp = await httpClient.post(
        '/users/$userId/schedules-coaching/$scheduleCoachingId/update',
        data: _requestBody);
    if (_resp.statusCode == 200) {
      return ScheduleCoachingModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
