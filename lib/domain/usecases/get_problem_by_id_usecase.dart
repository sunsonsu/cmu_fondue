/*
 * File: get_problem_by_id_usecase.dart
 * Description: Use case for fetching a single problem record by its ID.
 * Responsibilities: Orchestrates retrieval of problems and isolates the specific one required.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_repo.dart';

/// Executes the retrieval logic targeting one specific problem.
class GetProblemByIdUseCase {
  /// The dependent repository for fetching problem metrics.
  final ProblemRepo repository;

  /// Initializes a new instance of [GetProblemByIdUseCase].
  GetProblemByIdUseCase(this.repository);

  /// Searches for and returns a problem matching the supplied [problemId].
  ///
  /// This operates asynchronously. Optionally utilizes [userId] for establishing
  /// upvote states contextually. Checks memory lists to isolate the required ID.
  Future<ProblemEntity?> call({
    required String problemId,
    String? userId,
  }) async {
    try {
      final problems = await repository.getProblems(userId ?? '');
      return problems.firstWhere(
        (p) => p.id == problemId,
        orElse: () => throw Exception('Problem not found'),
      );
    } catch (e) {
      return null;
    }
  }
}
