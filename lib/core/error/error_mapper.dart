import 'package:flutter_clean_architecture/core/error/base_error.dart';

abstract class ErrorMapper {
  const ErrorMapper();

  BaseError map(Object error);
}
