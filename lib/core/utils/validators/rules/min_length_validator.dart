import 'package:flutter/material.dart';
import '../base_validator.dart';

class MinLengthValidator extends BaseValidator {
  final int min;
  final String? customMessage;

  const MinLengthValidator(this.min, {this.customMessage});

  @override
  bool validate(String value) => value.trim().length >= min;

  @override
  String message(BuildContext? context) =>
      customMessage ?? 'Must be at least $min characters';

/// How to use
/// TextFormField(
///   validator: Validators.combine(context, [
///     const RequiredValidator(),
///     const MinLengthValidator(),
///   ]),
/// )
}
