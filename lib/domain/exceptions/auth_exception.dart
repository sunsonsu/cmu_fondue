/*
 * File: auth_exception.dart
 * Description: Exception classes for handling authentication errors.
 * Responsibilities: Defines custom exceptions for various sign-in and sign-up failure states.
 * Author: Rachata
 * Course: CMU Fondue
 */

/// The base abstract class for all authentication-related exceptions.
abstract class AuthException implements Exception {
  /// The descriptive error message detailing the reason for the exception.
  final String message;

  /// Initializes a new instance of [AuthException].
  const AuthException(this.message);
}

/// Thrown when an explicitly malformed or invalid email address is provided.
class InvalidEmailException extends AuthException {
  /// Initializes a new instance of [InvalidEmailException].
  const InvalidEmailException() : super('Invalid email address');
}

/// Thrown when the password provided does not match the user's records.
class WrongPasswordException extends AuthException {
  /// Initializes a new instance of [WrongPasswordException].
  const WrongPasswordException() : super('Wrong password');
}

/// Thrown when no user record exists for the provided credentials.
class UserNotFoundException extends AuthException {
  /// Initializes a new instance of [UserNotFoundException].
  const UserNotFoundException() : super('Invalid email or password');
}

/// Thrown when attempting to register an email that is already registered.
class EmailAlreadyInUseException extends AuthException {
  /// Initializes a new instance of [EmailAlreadyInUseException].
  const EmailAlreadyInUseException() : super('Email already in use');
}

/// Thrown when the user provides a password that does not meet security criteria.
class WeakPasswordException extends AuthException {
  /// Initializes a new instance of [WeakPasswordException].
  const WeakPasswordException()
    : super('At least 8 characters with (A-Z, a-z, 0-9)');
}

/// Thrown when a password confirmation field does not match the primary password field.
class PasswordNotMatchException extends AuthException {
  /// Initializes a new instance of [PasswordNotMatchException].
  const PasswordNotMatchException() : super('Passwords do not match');
}

/// Thrown when an authentication process fails due to an unidentified reason.
class UnknownAuthException extends AuthException {
  /// Initializes a new instance of [UnknownAuthException].
  const UnknownAuthException() : super('Something went wrong');
}

/// Thrown when login credentials (like email/password combination) are outright invalid.
class InvalidCredentialsException extends AuthException {
  /// Initializes a new instance of [InvalidCredentialsException].
  const InvalidCredentialsException() : super('Invalid email or password');
}
