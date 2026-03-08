/*
 * File: get_problem_type_usecase.dart
 * Description: Use case for obtaining possible problem system categories.
 * Responsibilities: Coordinates the query to fetch categories from the repository.
 * Author: Komsan
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import '../entities/problem_type_entity.dart';
import '../repositories/problem_type_repo.dart';

/// Provides business logic to aggregate all acceptable report categories.
class GetProblemTypesUseCase {
  /// The configured repository managing categorical properties.
  final ProblemTypeRepo repository;

  /// Initializes a new instance of [GetProblemTypesUseCase].
  GetProblemTypesUseCase(this.repository);

  /// Triggers the fetching sequence for structural problem types.
  ///
  /// This operates asynchronously without needing parameters.
  Future<List<ProblemTypeEntity>> call() async {
    return await repository.getProblemTypes();
  }
}