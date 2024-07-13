// Project imports:
import 'base_error.dart';

class UnProcessableError extends BaseError {
  const UnProcessableError(String message, {super.statusCode})
      : super(message: message);

  factory UnProcessableError.defaultMessage() =>
      const UnProcessableError('unknown_error');

  @override
  String toString() {
    return "UnProcessableError(message: $message, statusCode: $statusCode)";
  }
}
