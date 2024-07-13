// Project imports:

import 'base_error.dart';

class CustomError extends BaseError {
  const CustomError({super.message});

  @override
  String toString() {
    return "$CustomError(message: $message, statusCode: $statusCode)";
  }
}

class EmailOrPhoneRequiredError extends CustomError {
  const EmailOrPhoneRequiredError({super.message});

  @override
  String toString() {
    return "$EmailOrPhoneRequiredError(message: $message, statusCode: $statusCode)";
  }
}

class EmailAlreadyExistError extends CustomError {
  const EmailAlreadyExistError({super.message});

  @override
  String toString() {
    return "$EmailAlreadyExistError(message: $message, statusCode: $statusCode)";
  }
}

class PhoneNumberAlreadyExistError extends CustomError {
  const PhoneNumberAlreadyExistError({super.message});

  @override
  String toString() {
    return "$PhoneNumberAlreadyExistError(message: $message, statusCode: $statusCode)";
  }
}

class CityNotExistsError extends CustomError {
  const CityNotExistsError({super.message});

  @override
  String toString() {
    return "$CityNotExistsError(message: $message, statusCode: $statusCode)";
  }
}

class CustomerTypesRequiredError extends CustomError {
  const CustomerTypesRequiredError({super.message});

  @override
  String toString() {
    return "$CustomerTypesRequiredError(message: $message, statusCode: $statusCode)";
  }
}

class NoCodeWasRegisteredError extends CustomError {
  const NoCodeWasRegisteredError({super.message});

  @override
  String toString() {
    return "$NoCodeWasRegisteredError(message: $message, statusCode: $statusCode)";
  }
}

class CodeMaxCountError extends CustomError {
  const CodeMaxCountError({super.message});

  @override
  String toString() {
    return "$CodeMaxCountError(message: $message, statusCode: $statusCode)";
  }
}

class NotValidUserError extends CustomError {
  const NotValidUserError({super.message}) ;

  @override
  String toString() {
    return "$NotValidUserError(message: $message, statusCode: $statusCode)";
  }
}

class NotValidUserNameOrPasswordError extends CustomError {
  const NotValidUserNameOrPasswordError({super.message})
      ;

  @override
  String toString() {
    return "$NotValidUserNameOrPasswordError(message: $message, statusCode: $statusCode)";
  }
}

class EmailNotConfirmedError extends CustomError {
  const EmailNotConfirmedError({super.message}) ;

  @override
  String toString() {
    return "$EmailNotConfirmedError(message: $message, statusCode: $statusCode)";
  }
}

class TokenError extends CustomError {
  const TokenError({super.message}) ;

  @override
  String toString() {
    return "$TokenError(message: $message, statusCode: $statusCode)";
  }
}

class SalonNotFoundError extends CustomError {
  const SalonNotFoundError({super.message}) ;

  @override
  String toString() {
    return "$SalonNotFoundError(message: $message, statusCode: $statusCode)";
  }
}

class NotValidCodeError extends CustomError {
  const NotValidCodeError({super.message}) ;

  @override
  String toString() {
    return "$NotValidCodeError(message: $message, statusCode: $statusCode)";
  }
}

class InvalidCartError extends CustomError {
  const InvalidCartError({super.message}) ;

  @override
  String toString() {
    return "$InvalidCartError(message: $message, statusCode: $statusCode)";
  }
}
