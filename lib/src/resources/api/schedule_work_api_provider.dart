import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/hours_model.dart';
import 'package:medical/src/models/schedule_work_model.dart';

class ScheduleWorkApiProvider extends ApiProvider {
  Future<ScheduleWorkListModel> scheduleWorkAccordingToDateTime({
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
    Response _resp = await httpClient.get('/users/$userId/schedules',
        queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return ScheduleWorkListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<ScheduleWorkModel> createScheduleWork({
    @required int userId,
    @required int partnerId,
    @required DateTime date,
    @required HoursModel hours,
  }) async {
    Map<String, dynamic> _requestBody = {
      'date': date.millisecondsSinceEpoch ~/ 1000,
      'partnerId': partnerId,
      'hours': hours.toJson(),
    };
    Response _resp =
        await httpClient.post('/users/$userId/schedules', data: _requestBody);
    if (_resp.statusCode == 200) {
      return ScheduleWorkModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<ScheduleWorkModel> updateScheduleWork(
    int scheduleId, {
    @required int userId,
    @required HoursModel realHours,
    @required ScheduleWorkType status,
    @required String purpose,
    @required String description,
  }) async {
    Map<String, dynamic> _requestBody = {
      'realHours': realHours.toJson(),
      'status': status.value,
      'purpose': purpose,
      'description': description,
    };
    Response _resp = await httpClient.post(
        '/users/$userId/schedules/$scheduleId/update',
        data: _requestBody);
    if (_resp.statusCode == 200) {
      return ScheduleWorkModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
