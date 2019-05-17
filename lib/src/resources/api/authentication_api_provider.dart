import 'api_provider.dart';
import 'api_response_error.dart';

class AuthenticationApiProvider extends ApiProvider {
  Future<String> authenticate({String username, String password}) async {
    Map<String, String> _requestBody = {
      'username': username,
      'password': password
    };
    Response _resp = await httpClient.post('/authenticate', data: _requestBody);
    if (_resp.statusCode == 200) {
      return _resp.data['token'];
    }
    return Future.error(_resp.data);
  }

  Future<bool> revoke() async {
    Response _resp = await httpClient.get('/revoke');
    if (_resp.statusCode == 204) {
      return true;
    }
    ApiResponseErrorList _errorList = ApiResponseErrorList.fromJson(_resp.data);
    return Future.error(_errorList.first.message);
  }
}
