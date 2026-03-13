/*
 * File: register.dart
 * Description: Use case for vetting and creating brand new accounts.
 * Responsibilities: Implements domain-specific constraints regarding account formation such as password integrity.
 * Author: Rachata 650510638
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/exceptions/auth_exception.dart';
import 'package:cmu_fondue/domain/repositories/auth_repo.dart';
import 'package:cmu_fondue/domain/entities/user_entity.dart';

/// Manages the validation gating and database triggering necessary to spawn a new user context.
class RegisterUseCase {
  /// The target repository handling downstream identity insertions.
  final AuthRepository repository;

  /// Initializes a new instance of [RegisterUseCase].
  RegisterUseCase(this.repository);

  /// Checks logical constraints before advancing the signing up process with [email] and [password].
  ///
  /// This operates asynchronously making remote commits once local checks pass. Requires
  /// a valid [confirmPassword] matching the primary input exactly.
  /// Throws a [PasswordNotMatchException] if they differ. Throws a [WeakPasswordException] if
  /// the required structural criteria are unmet.
  Future<UserEntity> call(
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      throw const PasswordNotMatchException();
    }

    if (!isValidPassword(password)) {
      throw const WeakPasswordException();
    }

    return repository.register(email, password);
  }

  /// Evaluates whether a proposed sequence meets acceptable criteria.
  ///
  /// The string must hold uppercase, lowercase, digits, and a minimum length of 8 strictly.
  bool isValidPassword(String password) {
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    final hasDigit = RegExp(r'\d').hasMatch(password);

    return hasUpper && hasLower && hasDigit && password.length >= 8;
  }
}
