import 'package:dio/dio.dart';
export 'package:dio/dio.dart';

abstract class ApiProvider {
  static const String apiBaseUrl = 'https://virtserver.swaggerhub.com/imark-team/medical';
  static const String apiVersionName = '1.0.0';
  static const String apiVersionPath = '1.0.0';

  static final _dio = Dio();

static void setBearerAuth(String token) {
_dio.options.headers.addAll({'Authorization': 'Bearer $token'});
}

final Dio httpClient;

ApiProvider() : httpClient = _dio {
_dio.options.baseUrl = '$apiBaseUrl/$apiVersionPath';
_dio.options.connectTimeout = 6000;
_dio.options.receiveTimeout = 6000;
_dio.options.responseType = ResponseType.json;
_dio.options.validateStatus = (status) => true;
_dio.options.receiveDataWhenStatusError = true;
_dio.interceptors.add(
LogInterceptor(error: true, requestBody: true, responseBody: true));
}
}