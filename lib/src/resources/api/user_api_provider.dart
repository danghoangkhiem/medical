import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

import 'package:medical/src/models/user_model.dart';

class UserApiProvider extends ApiProvider {
  Future<String> changePassword(
      {@required String oldPassword, @required String newPassword}) async {
    Map<String, String> _requestBody = {
      'oldPassword': oldPassword,
      'newPassword': newPassword
    };
    Response _resp = await httpClient.patch('/user/me', data: _requestBody);
    if (_resp.statusCode == 200) {
      return _resp.data['token'];
    }
    return Future.error(ApiResponseError.fromJson(_resp.data['error']));
  }

  Future<UserModel> getInfo() async {
    Response _resp = await httpClient.get('/user/me');
    if (_resp.statusCode == 200) {
      return UserModel.fromJson(_resp.data);
    }
    return Future.error(ApiResponseError.fromJson(_resp.data['error']));
  }
}
