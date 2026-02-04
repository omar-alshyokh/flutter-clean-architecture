import 'dart:async';
import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio _dio;
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({
    required Dio dio,
    this.maxRetries = 2,
    this.retryDelay = const Duration(milliseconds: 400),
  }) : _dio = dio;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final shouldRetry = _isRetryable(err);
    final retries = (err.requestOptions.extra['retries'] as int?) ?? 0;

    if (!shouldRetry || retries >= maxRetries) {
      handler.next(err);
      return;
    }

    err.requestOptions.extra['retries'] = retries + 1;

    await Future<void>.delayed(retryDelay);

    try {
      final response = await _dio.fetch<dynamic>(err.requestOptions);
      handler.resolve(response);
    } on DioException catch (err) {
      handler.next(err);
    }
  }

  bool _isRetryable(DioException err) {
    // Dio uses this for certificate problems in many cases
    if (err.type == DioExceptionType.badCertificate) return false;

    // Also avoid retrying handshake-related failures
    final msg = err.error?.toString().toLowerCase() ?? '';
    if (msg.contains('handshake') || msg.contains('certificate')) return false;

    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;
  }

}
