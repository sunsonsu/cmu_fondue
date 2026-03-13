/*
 * File: update_problem_upvote_usecase.dart
 * Description: Use case for issuing or stripping upvotes on problem entities.
 * Responsibilities: Rejects anonymous attempts and routes the toggle logic properly.
 * Author: Rachata 650510638
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/repositories/problem_repo.dart';

/// Isolates the logic required to modify the community consensus count for a problem.
class UpdateProblemUpvoteUseCase {
  /// The remote registry holding the consensus records.
  final ProblemRepo _problemRepository;

  /// Initializes a new instance of [UpdateProblemUpvoteUseCase].
  UpdateProblemUpvoteUseCase(this._problemRepository);

  /// Analyzes the [isUpvoted] intent over [problemId] securely.
  ///
  /// This operates asynchronously causing an upstream tally adjustment.
  /// Provides the acting [userId] explicitly.
  /// Throws an exception if the user context is absent.
  Future<void> call({
    required String problemId,
    required bool isUpvoted,
    String? userId,
  }) async {
    if (userId == null) {
      throw Exception('Login required to upvote a problem.');
    }

    if (isUpvoted) {
      return _problemRepository.addUpvote(id: problemId, userId: userId);
    } else {
      return _problemRepository.removeUpvote(id: problemId, userId: userId);
    }
  }
}
