/*
 * File: get_problem_image_by_problem_id_usecase.dart
 * Description: Use case for retrieving images tied directly to a problem.
 * Responsibilities: Passes the query to the image repository to fetch image representations.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/entities/problem_image_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_image_repo.dart';

/// Orchestrates the retrieval of all images assigned to a specific problem.
class GetProblemImagesByProblemIdUseCase {
  /// The underlying repository that maintains images.
  final ProblemImageRepo repository;

  /// Initializes a new instance of [GetProblemImagesByProblemIdUseCase].
  GetProblemImagesByProblemIdUseCase(this.repository);

  /// Requests the image sequence for the designated [problemId].
  ///
  /// This operates asynchronously.
  Future<List<ProblemImageEntity>> call(String problemId) async {
    return await repository.getProblemImageByProblemId(problemId);
  }
}
