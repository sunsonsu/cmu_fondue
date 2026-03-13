/*
 * File: user_repo.dart
 * Description: Abstract repository interface for user profile data operations.
 * Responsibilities: Declares the contract for updating tokens and retrieving user entries.
 * Author: Rachata 650510638 & Komsan 650510601
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/entities/user_entity.dart';

/// The contract for manipulating user models beyond strict authentication workflows.
abstract class UserRepo {
  /// Associates a new Firebase Cloud Messaging [token] to the targeted [userId].
  ///
  /// Side effects:
  /// Updates the remote record allowing pushes to successfully reach the specific user.
  Future<void> updateFcmToken(String userId, String token);

  /// Fetches the profile data corresponding precisely to the [userId].
  ///
  /// Returns null if the user does not exist.
  Future<UserEntity?> getUserById(String userId);
}
