// Project imports:
import 'base_error.dart';

class NoCacheDataFoundError extends BaseError {
  const NoCacheDataFoundError({String? message})
      : super(message: message ?? 'no_more_data_text');

  @override
  String toString() {
    return "NoCacheDataFoundError(message: $message, statusCode: $statusCode)";
  }
}
