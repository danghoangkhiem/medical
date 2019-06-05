import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/user_model.dart';
import 'package:medical/src/models/attendance_model.dart';

class UserApiProvider extends ApiProvider {
  Future<String> changePassword(
      {@required String oldPassword, @required String newPassword}) async {
    Map<String, String> _requestBody = {
      'oldPassword': oldPassword,
      'newPassword': newPassword
    };
    Response _resp = await httpClient.patch('/users/me', data: _requestBody);
    if (_resp.statusCode == 200) {
      return _resp.data['token'];
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<UserModel> getInfo() async {
    Response _resp = await httpClient.get('/users/me');
    if (_resp.statusCode == 200) {
      return UserModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<bool> isAttendanceTimeIn() async {
    Response _resp = await httpClient.get('/attendances/last');
    if (_resp.statusCode == 200) {
      return _resp.data != null &&
          _resp.data['timeIn'] != null &&
          _resp.data['timeOut'] == null;
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<AttendanceModel> getAttendanceLastTime() async {
    Response _resp = await httpClient.get('/attendances/last');
    if (_resp.statusCode == 200) {
      return _resp.data == null ? null : AttendanceModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
