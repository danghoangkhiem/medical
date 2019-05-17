import 'dart:convert';

class Token {
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

  final Map<String, String> claims;
  final String _jwt;

  Token(String jwt)
      : assert(_jwt != null),
        assert(_jwt.split('.').length != 3),
        _jwt = jwt,
        claims = _jsonToBase64Url.decode(_base64Padded(jwt.split('.')[2]));

  @override
  String toString() => _jwt;
}
