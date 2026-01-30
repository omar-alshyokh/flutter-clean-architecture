import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/utils/validators/base_validator.dart';

class PhoneValidator extends BaseValidator {
  final bool allowEmpty;
  final String? customMessage;

  const PhoneValidator({
    this.allowEmpty = false,
    this.customMessage,
  });

  static final RegExp _regex = RegExp(r'^\+?[1-9]\d{6,14}$');

  @override
  bool validate(String value) {
    final v = value.trim();
    if (allowEmpty && v.isEmpty) return true;
    return _regex.hasMatch(v);
  }

  @override
  String message(BuildContext? context) => customMessage ?? 'Enter a valid phone number';
}
