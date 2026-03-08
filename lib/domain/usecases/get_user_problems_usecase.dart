/*
 * File: get_user_problems_usecase.dart
 * Description: Use case for fetching problems recorded by a designated user.
 * Responsibilities: Requests filtered problem records restricted to those reported by a specific profile.
 * Author: App Team
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import '../repositories/problem_repo.dart';

/// Provides logic to fetch the history of problems reported by a specific individual.
class GetUserProblemsUseCase {
  /// The dependent repository supplying problem lists.
  final ProblemRepo repository;
  
  /// Initializes a new instance of [GetUserProblemsUseCase].
  GetUserProblemsUseCase(this.repository);

  /// Retrieves a list of issues authored by [reporterId].
  ///
  /// This operates asynchronously. Pass [currentUserId] to properly contextualize the upvote metadata.
  Future<List<ProblemEntity>> call({
    required String reporterId,
    required String currentUserId,
  }) async {
    return await repository.getProblemsByReporter(
      reporterId: reporterId,
      currentUserId: currentUserId,
    );
  }
}
