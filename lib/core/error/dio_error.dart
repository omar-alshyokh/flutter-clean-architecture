// Project imports:
import 'base_error.dart';

class BaseDioError extends BaseError {
  const BaseDioError(String? message, String? statusCode)
      : super(message: message, statusCode: statusCode);
}

class CancelDioError extends BaseDioError {
  const CancelDioError({String? message, String? statusCode})
      : super(message ?? 'dio_cancel_error', statusCode);

  @override
  String toString() {
    return "CancelDioError(message: $message, statusCode: $statusCode)";
  }
}

class ConnectTimeoutDioError extends BaseDioError {
  const ConnectTimeoutDioError({String? message, String? statusCode})
      : super(message ?? 'dio_connection_timeout_error', statusCode);

  @override
  String toString() {
    return "ConnectTimeoutDioError(message: $message, statusCode: $statusCode)";
  }
}

class ReceiveTimeoutDioError extends BaseDioError {
  const ReceiveTimeoutDioError({String? message, String? statusCode})
      : super(message ?? 'dio_receive_connection_timeout_error',
            statusCode);

  @override
  String toString() {
    return "ReceiveTimeoutDioError(message: $message, statusCode: $statusCode)";
  }
}

class ConnectionDioError extends BaseDioError {
  const ConnectionDioError({String? message, String? statusCode})
      : super(message ?? 'something_went_wrong_check_connection',
            statusCode);

  @override
  String toString() {
    return "ConnectionDioError(message: $message, statusCode: $statusCode)";
  }
}

class ResponseDioError extends BaseDioError {
  const ResponseDioError({String? message, String? statusCode})
      : super(message ?? 'error_unexpected', statusCode);

  @override
  String toString() {
    return "ResponseDioError(message: $message, statusCode: $statusCode)";
  }
}

class SendTimeoutDioError extends BaseDioError {
  const SendTimeoutDioError({String? message, String? statusCode})
      : super(message ?? 'dio_send_timeout_to_the_server', statusCode);

  @override
  String toString() {
    return "SendTimeoutDioError(message: $message, statusCode: $statusCode)";
  }
}

class BadRequestDioError extends BaseDioError {
  const BadRequestDioError({String? message, String? statusCode})
      : super(message ?? 'dio_bad_request_error', statusCode);

  @override
  String toString() {
    return "BadRequestDioError(message: $message, statusCode: $statusCode)";
  }
}

class NotFoundDioError extends BaseDioError {
  const NotFoundDioError({String? message, String? statusCode})
      : super(message ?? 'dio_not_found_error', statusCode);

  @override
  String toString() {
    return "NotFoundDioError(message: $message, statusCode: $statusCode)";
  }
}

class InternalServerError extends BaseError {
  const InternalServerError({String? message, String? statusCode})
      : super(
            message: message ?? 'error_unexpected',
            statusCode: statusCode);

  @override
  String toString() {
    return "InternalServerError(message: $message, statusCode: $statusCode)";
  }
}

class NetworkConnectionError extends BaseError {
  const NetworkConnectionError(String? statusCode)
      : super(message: 'connection_error', statusCode: statusCode);

  @override
  String toString() {
    return "NetworkConnectionError(message: $message, statusCode: $statusCode)";
  }
}
