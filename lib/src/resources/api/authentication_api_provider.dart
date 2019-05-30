import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'api_response_error.dart';

class AuthenticationApiProvider extends ApiProvider {
  Future<String> authenticate(
      {@required String username, @required String password}) async {
    Map<String, String> _requestBody = {
      'username': username,
      'password': password
    };
    Response _resp = await httpClient.post('/authenticate', data: _requestBody);
    if (_resp.statusCode == 200) {
      return _resp.data['token'];
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }

  Future<bool> revoke() async {
    Response _resp = await httpClient.get('/revoke');
    if (_resp.statusCode == 204) {
      return true;
    }
    return Future.error(ApiResponseError.fromJson(_resp.data));
  }
}
