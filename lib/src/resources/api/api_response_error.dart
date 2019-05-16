import 'dart:collection';

class ApiResponseError {
  final int code;
  final String message;

  ApiResponseError({this.code, this.message});

  ApiResponseError.fromJson(Map<String, dynamic> json)
      : assert(json['code'] != null),
        code = json['code'],
        message = json['message'];

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message};
  }
}

class ApiResponseErrorList extends ListMixin<ApiResponseError> {
  List<ApiResponseError> _responseErrorList = List();

  ApiResponseErrorList.fromJson(Map<dynamic, dynamic> json)
      : assert(json['errors'] != null) {
    List.from(json['errors']).forEach(
        (item) => _responseErrorList.add(ApiResponseError.fromJson(item)));
  }

  @override
  int get length => _responseErrorList.length;

  @override
  set length(value) => _responseErrorList.length = value;

  @override
  operator [](int index) {
    return _responseErrorList[index];
  }

  @override
  void operator []=(int index, value) {
    if (_responseErrorList.length == index) {
      _responseErrorList.add(value);
    } else {
      _responseErrorList[index] = value;
    }
  }
}
