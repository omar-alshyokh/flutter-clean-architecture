// Project imports:
import 'base_error.dart';

class UnexpectedError extends BaseError {
  const UnexpectedError({super.message, super.statusCode});

  factory UnexpectedError.defaultMessage() =>
      const UnexpectedError(message: 'error_unexpected');

  @override
  String toString() {
    return "UnexpectedError(message: $message, statusCode: $statusCode)";
  }
}
