import 'package:flutter_clean_architecture/core/error/base_error.dart';

class UnknownError extends BaseError {
  const UnknownError({super.message, super.code});
}

class NetworkConnectionError extends BaseError {
  const NetworkConnectionError({super.message, super.code});
}

class TimeoutError extends BaseError {
  const TimeoutError({super.message, super.code});
}

class UnauthorizedError extends BaseError {
  const UnauthorizedError({super.message, super.code});
}

class ForbiddenError extends BaseError {
  const ForbiddenError({super.message, super.code});
}

class NotFoundError extends BaseError {
  const NotFoundError({super.message, super.code});
}

class UnProcessableError extends BaseError {
  const UnProcessableError({super.message, super.code});
}

class InternalServerError extends BaseError {
  const InternalServerError({super.message, super.code});
}

class CustomError extends BaseError {
  const CustomError({super.message, super.code});
}
