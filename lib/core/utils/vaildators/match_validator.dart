import 'package:flutter/material.dart';
import 'base_validator.dart';


class MatchValidator extends BaseValidator {
  String value;

  MatchValidator({required this.value});

  @override
  String getMessage(BuildContext? context) {
    /// todo: add translate message
    return "There is no match";
  }

  @override
  bool validate(String value) {
    return value == this.value;
  }
}
