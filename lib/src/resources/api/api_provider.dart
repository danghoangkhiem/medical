import 'package:dio/dio.dart';
export 'package:dio/dio.dart';

abstract class ApiProvider {
  static const String apiBaseUrl = 'https://fmapi.imark.com.vn';
  static const String apiVersionName = '1.0';
  static const String apiVersionPath = 'v1';

  static final _dio = Dio(BaseOptions(
    baseUrl: '$apiBaseUrl/$apiVersionPath',
    connectTimeout: 6000,
    receiveTimeout: 6000,
    responseType: ResponseType.json,
    validateStatus: (status) => true,
    receiveDataWhenStatusError: true,
  ));

  static void setBearerAuth(String token) {
    _dio.options.headers.addAll({'Authorization': ' Bearer $token'});
  }

  final Dio httpClient;

  ApiProvider() : httpClient = _dio {
    if (_dio.interceptors.isEmpty) {
      _dio.interceptors.add(
          LogInterceptor(error: true, requestBody: true, responseBody: true));
    }
  }
}
