import 'package:flutter/material.dart';
import 'package:starter/core/utils/app_utils.dart';

import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  bool? isFromVerificationPage;

  RequiredValidator({this.isFromVerificationPage});

  @override
  String getMessage(BuildContext? context) {
    /// todo: add translate message
    if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
    /// todo: add translate message
    return "This field is required";
  }

  @override
  bool validate(String value) {
    return value.isNotEmpty;
  }
}
class DateValidator extends BaseValidator {
  String? dateFormat;

  DateValidator({this.dateFormat});

  @override
  String getMessage(BuildContext? context) {

    return "Date is not valid";
  }

  @override
  bool validate(String value) {
    return AppUtils.isDateWithFormat(input: value, format: dateFormat);
  }
}
class RequiredSmallMessageValidator extends BaseValidator {
  bool? isFromVerificationPage;

  RequiredSmallMessageValidator({this.isFromVerificationPage});

  @override
  String getMessage(BuildContext? context) {
    /// todo: add translate message
    if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
    return "required";
  }

  @override
  bool validate(String value) {
    return value.isNotEmpty;
  }
}
