class AppException implements Exception {
  AppException([
    this._message,
    this._prefix,
    this._code,
  ]);
  final String? _message;
  final String? _prefix;
  final String? _code;

  @override
  String toString() {
    return '$_code&&$_prefix##$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([
    String? message,
    String? code,
  ]) : super(message, '', code);
}

class BadRequestException extends AppException {
  BadRequestException([
    String? message,
    String? code,
  ]) : super(message, 'Invalid Request:', code);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([
    String? message,
    String? code,
  ]) : super(message, 'Unauthorized:', code);
}

class InvalidInputException extends AppException {
  InvalidInputException([
    String? message,
    String? code,
  ]) : super(message, 'Invalid Input\n\n', code);
}

class UnprocessableEntity extends AppException {
  UnprocessableEntity([
    String? message,
    String? code,
  ]) : super(message, 'Unprocessable Entity\n\n', code);
}

class NotFoundException extends AppException {
  NotFoundException([
    String? message,
    String? code,
  ]) : super(message, 'Not Found:', code);
}

class InternalServerException extends AppException {
  InternalServerException([
    String? message,
    String? code,
  ]) : super(message, 'Internal Server Error:', code);
}

class UserNotFoundException extends AppException {
  UserNotFoundException([
    String? message,
    String? code,
  ]) : super(message, 'User Not Found:', code);
}

class ProxyAuthenticationRequired extends AppException {
  ProxyAuthenticationRequired([
    String? message,
    String? code,
  ]) : super(message, 'Proxy authentication:', code);
}

class ResetUserException extends AppException {
  ResetUserException([
    String? message,
    String? code,
  ]) : super(message, '', code);
}
