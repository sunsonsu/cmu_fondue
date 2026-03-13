/*
 * File: get_user_by_id_usecase.dart
 * Description: Use case for fetching a specific profile user entity.
 * Responsibilities: Isolates and grabs targeted user data based purely on a database ID string.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/entities/user_entity.dart';
import 'package:cmu_fondue/domain/repositories/user_repo.dart';

/// Processes retrieval requests for specific user accounts.
class GetUserByIdUseCase {
  /// The dependent registry maintaining user boundaries.
  final UserRepo repository;

  /// Initializes a new instance of [GetUserByIdUseCase].
  GetUserByIdUseCase(this.repository);

  /// Requests targeted access to the profile matched by [userId].
  ///
  /// This operates asynchronously. It relies entirely on the repository returning proper records.
  Future<UserEntity?> call(String userId) async {
    return await repository.getUserById(userId);
  }
}
