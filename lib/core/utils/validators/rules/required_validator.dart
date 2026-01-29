import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/utils/validators/base_validator.dart';

class RequiredValidator extends BaseValidator {
  final String? customMessage;

  const RequiredValidator({this.customMessage});

  @override
  bool validate(String value) => value.trim().isNotEmpty;

  @override
  String message(BuildContext? context) =>
      customMessage ?? 'This field is required';
}
