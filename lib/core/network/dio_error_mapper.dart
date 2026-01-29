import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/error/base_error.dart';
import 'package:flutter_clean_architecture/core/error/error_mapper.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';


class DioErrorMapper implements ErrorMapper {
  const DioErrorMapper();

  @override
  BaseError map(Object error) {
    if (error is DioException) {
      return _mapDioException(error);
    }
    return const UnknownError(message: 'Unexpected error occurred');
  }

  BaseError _mapDioException(DioException exception) {
    final statusCode = exception.response?.statusCode?.toString();

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutError(
          message: 'Request timed out',
          code: statusCode,
        );

      case DioExceptionType.connectionError:
        return NetworkConnectionError(
          message: 'No internet connection',
          code: statusCode,
        );

      case DioExceptionType.badResponse:
        return _mapHttpStatus(exception.response?.statusCode, exception);

      case DioExceptionType.cancel:
        return const CustomError(message: 'Request cancelled');

      case DioExceptionType.badCertificate:
        return const CustomError(message: 'Bad certificate');

      case DioExceptionType.unknown:
        return UnknownError(
          message: exception.message ?? 'Unexpected error occurred',
          code: statusCode,
        );
    }
  }

  BaseError _mapHttpStatus(int? statusCode, DioException exception) {
    final serverMessage = _extractServerMessage(exception);
    final code = statusCode?.toString();

    if (statusCode == 401) {
      return UnauthorizedError(
        message: serverMessage ?? 'Unauthorized',
        code: code,
      );
    }

    if (statusCode == 403) {
      return ForbiddenError(
        message: serverMessage ?? 'Forbidden',
        code: code,
      );
    }

    if (statusCode == 404) {
      return NotFoundError(
        message: serverMessage ?? 'Not found',
        code: code,
      );
    }

    if (statusCode == 422) {
      return UnProcessableError(
        message: serverMessage ?? 'Invalid request',
        code: code,
      );
    }

    if (statusCode != null && statusCode >= 500) {
      return InternalServerError(
        message: serverMessage ?? 'Server error',
        code: code,
      );
    }

    return UnknownError(
      message: serverMessage ?? 'Request failed',
      code: code,
    );
  }

  String? _extractServerMessage(DioException exception) {
    final data = exception.response?.data;

    if (data is Map<String, dynamic>) {
      final msg = data['message'];
      if (msg is String && msg.trim().isNotEmpty) {
        return msg.trim();
      }
    }

    if (data is String && data.trim().isNotEmpty) {
      return data.trim();
    }

    return null;
  }
}
