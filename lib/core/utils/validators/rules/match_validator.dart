import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/utils/validators/base_validator.dart';

class MatchValidator extends BaseValidator {
  final String Function() otherValue;
  final String? customMessage;

  const MatchValidator({
    required this.otherValue,
    this.customMessage,
  });

  @override
  bool validate(String value) => value == otherValue();

  @override
  String message(BuildContext? context) =>
      customMessage ?? 'Values do not match';

  /// How to use
  /// final passwordController = TextEditingController();
  ///
  /// TextFormField(
  ///   controller: passwordController,
  /// );
  /// TextFormField(
  ///   validator: Validators.combine(context, [
  ///     const RequiredValidator(),
  ///     MatchValidator(otherValue: () => passwordController.text),
  ///   ]),
  /// )
}
