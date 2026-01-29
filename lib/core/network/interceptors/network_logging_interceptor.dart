import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkLoggingInterceptor extends Interceptor {
  final PrettyDioLogger _logger;

  NetworkLoggingInterceptor({
    required bool logRequestHeaders,
    required bool logRequestBody,
    required bool logResponseBody,
    required bool logResponseHeaders,
  }) : _logger = PrettyDioLogger(
         requestHeader: logRequestHeaders,
         requestBody: logRequestBody,
         responseBody: logResponseBody,
         responseHeader: logResponseHeaders,
         maxWidth: 120,
       );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _logger.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.onError(err, handler);
  }
}
