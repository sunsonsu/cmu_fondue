abstract class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
}

class InvalidEmailException extends AuthException {
  const InvalidEmailException() : super('Invalid email address');
}

class WrongPasswordException extends AuthException {
  const WrongPasswordException() : super('Wrong password');
}

class UserNotFoundException extends AuthException {
  const UserNotFoundException() : super('Invalid email or password');
}

class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException() : super('Email already in use');
}

class WeakPasswordException extends AuthException {
  const WeakPasswordException()
    : super('At least 8 characters with (A-Z, a-z, 0-9)');
}

class PasswordNotMatchException extends AuthException {
  const PasswordNotMatchException() : super('Passwords do not match');
}

class UnknownAuthException extends AuthException {
  const UnknownAuthException() : super('Something went wrong');
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException()
      : super('Invalid email or password');
}
