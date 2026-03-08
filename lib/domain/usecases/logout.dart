/*
 * File: logout.dart
 * Description: Use case responsible for severing the active session.
 * Responsibilities: Directs the authentication datastore to drop current keys or tokens.
 * Author: App Team
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/repositories/auth_repo.dart';

/// Manages the process of properly finalizing a user session.
class LogoutUseCase {
  /// The dependent registry maintaining the active session.
  final AuthRepository repository;

  /// Initializes a new instance of [LogoutUseCase].
  LogoutUseCase(this.repository);

  /// Requests the immediate termination of the currently signed in user instance.
  ///
  /// This operates asynchronously and signals the auth system.
  Future<void> call() {
    return repository.logout();
  }
}
