/*
 * File: problem_tag_repo.dart
 * Description: Abstract repository interface for problem tag data operations.
 * Responsibilities: Declares the contract for accessing available tag classifications.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/entities/problem_tag_entity.dart';

/// The contract for retrieving all status tags applicable to problems.
abstract class ProblemTagRepo {
  /// Fetches a complete list of valid problem status tags.
  ///
  /// This operates asynchronously and interacts with the datastore.
  Future<List<ProblemTagEntity>> getAllProblemTags();

  /// Re-inserts or registers a generalized problem tag.
  ///
  /// Side effects:
  /// Generates a corresponding tag instance in the database.
  Future<void> insertProblemTag();
}
