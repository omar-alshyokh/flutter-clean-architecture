import 'package:flutter/material.dart';

abstract class BaseValidator {
  const BaseValidator();

  bool validate(String value);

  String message(BuildContext? context);

  static String? validateValue(
    BuildContext? context,
    String? value,
    List<BaseValidator> validators, {
    bool stopOnFirstError = true,
  }) {
    final v = value ?? '';
    for (final validator in validators) {
      if (!validator.validate(v)) {
        return validator.message(context);
      }
      if (!stopOnFirstError) {
        continue;
      }
    }
    return null;
  }
}
