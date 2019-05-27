import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api/authentication_api_provider.dart';

class AuthenticationRepository {
  final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
  final AuthenticationApiProvider _authenticationApiProvider =
      AuthenticationApiProvider();

  Future<String> authenticate({String username, String password}) async {
    return await _authenticationApiProvider.authenticate(
        username: username, password: password);
  }

  Future<bool> revoke() async {
    await deleteToken();
    return await _authenticationApiProvider.revoke();
  }

  Future<void> persistToken(String token) async {
    await _flutterSecureStorage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await _flutterSecureStorage.delete(key: 'token');
  }

  Future<String> getToken() async {
    return await _flutterSecureStorage.read(key: 'token');
  }

  Future<bool> isValid() async {
    final String _token = await getToken();
    if (_token == null) {
      return false;
    }
    final List<String> _parse = _token.split('.');
    if (_parse.length != 3) {
      return false;
    }
    final Map<String, dynamic> _claims =
        _jsonToBase64Url.decode(_base64Padded(_parse[1]));
    if (!_claims.containsKey('exp')) {
      return false;
    }
    final DateTime _expireTime =
        DateTime.fromMillisecondsSinceEpoch(_claims['exp'] * 1000);
    if (_expireTime.isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }

  static final _jsonToBase64Url = json.fuse(utf8.fuse(base64Url));

  static String _base64Padded(String value) {
    var mod = value.length % 4;
    if (mod == 0) {
      return value;
    } else if (mod == 3) {
      return value.padRight(value.length + 1, '=');
    } else if (mod == 2) {
      return value.padRight(value.length + 2, '=');
    } else {
      return value;
    }
  }
}
