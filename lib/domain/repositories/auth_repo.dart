/*
 * File: auth_repo.dart
 * Description: Abstract repository interface for authentication operations.
 * Responsibilities: Declares the contract for authenticating, registering, and managing user sessions.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/entities/user_entity.dart';

/// The contract for interacting with the authentication data source.
abstract class AuthRepository {
  /// Authenticates a user using their [email] and [password].
  ///
  /// This operates asynchronously and communicates with the remote auth provider.
  /// Throws an [AuthException] on failure.
  Future<UserEntity> login(String email, String password);

  /// Registers a new user account with the provided [email] and [password].
  ///
  /// This creates a new record in the remote auth provider.
  /// Throws an [AuthException] on registration failure.
  Future<UserEntity> register(String email, String password);

  /// Emits updates whenever the user's authentication state changes.
  Stream<UserEntity?> authStateChanges();

  /// The currently authenticated user, or null if unauthenticated.
  UserEntity? get currentUser;

  /// Signs the current user out of the application.
  ///
  /// Side effects:
  /// Clears the active session and notifies any active listeners of [authStateChanges].
  Future<void> logout();
}
