import 'package:flutter/material.dart';
import '../base_validator.dart';

/// generic rule for custom regex
class PatternValidator extends BaseValidator {
  final RegExp pattern;
  final String messageText;
  final bool allowEmpty;

  const PatternValidator({
    required this.pattern,
    required this.messageText,
    this.allowEmpty = false,
  });

  @override
  bool validate(String value) {
    final v = value.trim();
    if (allowEmpty && v.isEmpty) return true;
    return pattern.hasMatch(v);
  }

  @override
  String message(BuildContext? context) => messageText;
}
