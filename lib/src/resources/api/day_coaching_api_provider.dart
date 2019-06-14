import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/day_coaching_model.dart';

class DayCoachingApiProvider extends ApiProvider {
  Future<DayCoachingListModel> getDayCoaching(
      {int offset = 0, int limit = 10, @required int userId}) async {
    Map<String, dynamic> _queryParameters = {
      'offset': offset,
      'limit': limit,
    };
    Response _resp = await httpClient.get(
        '/users/' + userId.toString() + '/schedules',
        queryParameters: _queryParameters);
    if (_resp.statusCode == 200) {
      return DayCoachingListModel.fromJson(_resp.data['data']);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
