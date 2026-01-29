import 'package:flutter/material.dart';
import '../base_validator.dart';

class MaxLengthValidator extends BaseValidator {
  final int max;
  final String? customMessage;

  const MaxLengthValidator(this.max, {this.customMessage});

  @override
  bool validate(String value) => value.trim().length <= max;

  @override
  String message(BuildContext? context) =>
      customMessage ?? 'Must be $max characters or fewer';
}
