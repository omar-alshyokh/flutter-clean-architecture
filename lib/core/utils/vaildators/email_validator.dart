import 'package:flutter/material.dart';
import 'base_validator.dart';


class EmailValidator extends BaseValidator {
  @override
  String getMessage(BuildContext? context) {
    /// todo: add translate message
    return 'invalid email';
  }

  @override
  bool validate(String value) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(value);
  }
}
