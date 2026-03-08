/*
 * File: login.dart
 * Description: Use case spanning the core authentication login flow.
 * Responsibilities: Validates credentials broadly and forwards login commands to the auth repository.
 * Author: App Team
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/repositories/auth_repo.dart';
import 'package:cmu_fondue/domain/entities/user_entity.dart';

/// Governs the business constraints and execution of logging a user into their account.
class LoginUseCase {
  /// The underlying authentication registry dependency.
  final AuthRepository repository;

  /// Initializes a new instance of [LoginUseCase].
  LoginUseCase(this.repository);

  /// Validates inputs and triggers the login process using [email] and [password].
  ///
  /// This operates asynchronously and conducts network operations to authorize the user.
  /// Throws an exception if either field is left empty or if the remote repository rejects the credentials.
  Future<UserEntity> call(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Invalid credentials');
    }

    return repository.login(email, password);
  }
}
