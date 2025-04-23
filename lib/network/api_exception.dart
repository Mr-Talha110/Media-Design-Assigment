class ApiException implements Exception {
  final String? _message;
  final String? _prefix;

  ApiException(this._message, this._prefix);
  String? get message => _message;
  String? get prefix => _prefix;

  @override
  String toString() {
    return 'Prefix: $_prefix\nMessage:$_message';
  }
}

class NoInternetException extends ApiException {
  NoInternetException(String? message)
    : super(message, 'No internet Exception');
}

class ServerException extends ApiException {
  ServerException(String? message) : super(message, 'Internal Server Error');
}

class TimeoutException extends ApiException {
  TimeoutException(String? message) : super(message, 'Server times out');
}

class InvalidUrlException extends ApiException {
  InvalidUrlException(String? message) : super(message, 'Invalid Url');
}

class InvalidCredentialsException extends ApiException {
  InvalidCredentialsException(super.message, super.prefix);
}

class AppExceptionDio implements Exception {
  final String message;
  final String prefix;

  AppExceptionDio({required this.message, required this.prefix});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppExceptionDio {
  FetchDataException(String message)
    : super(message: message, prefix: "Error During Communication: ");
}

class BadRequestException extends AppExceptionDio {
  // In this class we will add more checks on the code returned from API, and return the correct message on each case
  BadRequestException(String message)
    : super(message: getErrorMessage(message), prefix: "");

  static getErrorMessage(dynamic message) {
    return message;
  }
}

class UnauthorisedException extends AppExceptionDio {
  UnauthorisedException([message])
    : super(
        message: "Looks like your sessions is expired, please login again",
        prefix: "",
      );
}

class UserNotFoundException extends AppExceptionDio {
  UserNotFoundException(String message)
    : super(message: "Username does not exist", prefix: "");
}

class InternalServerException extends AppExceptionDio {
  InternalServerException([message])
    : super(
        message:
            "Ops Looks like there is an error with our servers, Please try gain later",
        prefix: "",
      );
}

class TooManyRequestsException extends AppExceptionDio {
  TooManyRequestsException(String message)
    : super(
        message: "Failed to complete your operation, Please try again",
        prefix: "",
      );
}

class IncorrectUsernameOrPassword extends AppExceptionDio {
  IncorrectUsernameOrPassword([message])
    : super(message: message.toString(), prefix: "");
}

class Failure {
  final String message;

  Failure({required this.message});
}
