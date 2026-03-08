/*
 * File: user_entity.dart
 * Description: Entity representing a user of the application.
 * Responsibilities: Encapsulates user profile details, roles, and device tokens. Contains factories for mapping from Firebase Auth and generated SDK data.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Represents a user securely authenticated within the system.
class UserEntity {
  /// The unique identifier of the user.
  final String id;

  /// The email address associated with the user account.
  final String email;

  /// Whether the user possesses administrator privileges.
  final bool isAdmin;

  /// The device-specific FCM token used for push notifications.
  final String? fcmToken;

  /// Initializes a new instance of [UserEntity].
  UserEntity({
    required this.id,
    required this.email,
    required this.isAdmin,
    this.fcmToken,
  });

  /// Constructs an entity directly from a corresponding Firebase [User].
  factory UserEntity.fromFirebase(User user) {
    return UserEntity(
      id: user.uid,
      email: user.email ?? '',
      isAdmin: user.uid == dotenv.env['UID_ADMIN'],
    );
  }

  /// Constructs an entity from dynamic generated SDK data.
  factory UserEntity.fromGenerated(dynamic data) {
    return UserEntity(
      id: data.userId,
      email: data.email,
      isAdmin: data.isAdmin,
      fcmToken: data.fcmToken,
    );
  }
}
