import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('\n' + '=' * 80);
    debugPrint('🚀 API REQUEST');
    debugPrint('METHOD: ${options.method}');
    debugPrint('URL: ${options.uri}');
    debugPrint('HEADERS: ${options.headers}');
    
    // Explicitly log the token if present
    if (options.headers.containsKey('Authorization')) {
      debugPrint('TOKEN: ${options.headers['Authorization']}');
    } else if (options.headers.containsKey('authorization')) {
       debugPrint('TOKEN: ${options.headers['authorization']}');
    }

    if (options.data != null) {
      if (options.data is FormData) {
        debugPrint('BODY (Fields): ${options.data.fields}');
        debugPrint('BODY (Files): ${options.data.files.map((e) => e.key).toList()}');
      } else {
        debugPrint('BODY: ${options.data}');
      }
    }
    debugPrint('=' * 80 + '\n');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('\n' + '=' * 80);
    debugPrint('✅ API RESPONSE');
    debugPrint('URL: ${response.requestOptions.uri}');
    debugPrint('STATUS CODE: ${response.statusCode}');
    debugPrint('DATA: ${response.data}');
    debugPrint('=' * 80 + '\n');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('\n' + '❌' * 40);
    debugPrint('‼️ API ERROR');
    debugPrint('URL: ${err.requestOptions.uri}');
    debugPrint('METHOD: ${err.requestOptions.method}');
    debugPrint('ERROR: ${err.message}');
    if (err.response != null) {
      debugPrint('STATUS CODE: ${err.response?.statusCode}');
      debugPrint('RESPONSE DATA: ${err.response?.data}');
    }
    debugPrint('❌' * 40 + '\n');
    return super.onError(err, handler);
  }
}
