/*
 * File: problem_type_repo.dart
 * Description: Abstract repository interface for problem category types.
 * Responsibilities: Declares the contract for fetching the possible problem type listings.
 * Author: Komsan
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/entities/problem_type_entity.dart';

/// The contract for retrieving all structural problem types.
abstract class ProblemTypeRepo {
  /// Retrieves everyone available problem categories.
  ///
  /// Operates asynchronously and is generally used to populate UI selections.
  Future<List<ProblemTypeEntity>> getProblemTypes();
}
