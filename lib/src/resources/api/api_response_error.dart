import 'dart:collection';

class ApiResponseError {
  final int code;
  final String message;

  ApiResponseError({this.code, this.message});

  ApiResponseError.fromJson(Map<String, dynamic> json)
      : assert(json['code'] != null),
        code = json['code'] as int,
        message = json['message'] as String;

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message};
  }

  String toString() => message.toString();
}

class ApiResponseErrorList extends ListMixin<ApiResponseError> {
  List<ApiResponseError> _list = List();

  ApiResponseErrorList.fromJson(List<dynamic> json) : assert(json != null) {
    List.from(json).forEach(
        (item) => _list.add(ApiResponseError.fromJson(item)));
  }

  @override
  int get length => _list.length;

  @override
  set length(value) => _list.length = value;

  @override
  operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, value) {
    if (_list.length == index) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }
}
