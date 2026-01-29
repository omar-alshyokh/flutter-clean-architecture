import 'package:flutter/material.dart';
import '../base_validator.dart';

class EmailValidator extends BaseValidator {
  final bool allowEmpty;
  final String? customMessage;

  const EmailValidator({
    this.allowEmpty = false,
    this.customMessage,
  });

  static final RegExp _regex = RegExp(
    r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$',
  );

  @override
  bool validate(String value) {
    final v = value.trim();
    if (allowEmpty && v.isEmpty) return true;
    return _regex.hasMatch(v);
  }

  @override
  String message(BuildContext? context) => customMessage ?? 'Enter a valid email address';

  /// How to use
  /// TextFormField(
  ///   validator: Validators.combine(context, [
  ///     const RequiredValidator(),
  ///     const EmailValidator(),
  ///   ]),
  /// )
}
