import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/utils/validators/base_validator.dart';

typedef FieldValidator = String? Function(String? value);

class Validators {
  const Validators._();

  static FieldValidator combine(
    BuildContext context,
    List<BaseValidator> validators,
  ) {
    return (value) => BaseValidator.validateValue(context, value, validators);
  }

  /// how to use
  /// TextFormField(
  ///   validator: Validators.combine(context, [
  ///     const RequiredValidator(),
  ///     const EmailValidator(),
  ///   ]),
  /// )
}
