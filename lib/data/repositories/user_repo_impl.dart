/*
 * File: user_repo_impl.dart
 * Description: Concrete implementation of the UserRepo.
 * Responsibilities: Manages user metadata and push token assignments via Firebase Data Connect.
 * Author: App Team
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/user_entity.dart';
import 'package:cmu_fondue/domain/repositories/user_repo.dart';

/// Implements domain specifications tracking application members connecting via Firebase Data Connect.
class UserRepoImpl implements UserRepo {
  /// The generated connector executing direct GraphQL mutations.
  final ConnectorConnector connector;

  /// Initializes a new instance of [UserRepoImpl].
  UserRepoImpl({required this.connector});

  @override
  Future<void> updateFcmToken(String userId, String token) async {
    await connector.updateFcmToken(userId: userId, fcmToken: token).execute();
  }

  @override
  Future<UserEntity?> getUserById(String userId) async {
    try {
      final result = await connector.getUserById(userId: userId).execute();
      if (result.data.user == null) {
        return null;
      }
      return UserEntity.fromGenerated(result.data.user!);
    } catch (e) {
      throw Exception("ไม่สามารถดึงข้อมูล user ได้: $e");
    }
  }
}