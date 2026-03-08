/*
 * File: problem_repo.dart
 * Description: Abstract repository interface for problem data operations.
 * Responsibilities: Declares the contract for creating, fetching, updating, and deleting problems, as well as managing upvotes.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/entities/problem_entity.dart';

/// The contract for interacting with all primary problem data in the system.
abstract class ProblemRepo {
  /// Retrieves a complete list of all recorded problems.
  ///
  /// Uses [userId] to ascertain if the user has already upvoted specific items.
  Future<List<ProblemEntity>> getProblems(String userId);

  /// Retrieves a list of problems that have not yet reached the completed state.
  ///
  /// Pass [userId] to properly contextualize user-specific upvote states.
  Future<List<ProblemEntity>> getNotCompletedProblems(String userId);

  /// Creates a completely new problem entry.
  ///
  /// Use all provided required fields to build the metadata, assigning it to [reporterId].
  /// Returns the generated identifier of the new problem.
  Future<String> createProblem({
    required String title,
    required String detail,
    required String locationName,
    required double lat,
    required double lng,
    required String reporterId,
    required String typeId,
    required String tagId,
  });

  /// Modifies an existing problem referenced by [id].
  ///
  /// Any parameter not explicitly provided as null maintains its previous value.
  Future<void> updateProblem({
    required String id,
    String? title,
    String? detail,
    String? locationName,
    double? lat,
    double? lng,
    String? typeId,
    String? tagId,
  });

  /// Permanently deletes the problem identified by [id].
  ///
  /// Side effects:
  /// Erases the problem from the remote datastore.
  Future<void> deleteProblem(String id);

  /// Calculates the total number of problems matching the [currentTagId].
  Future<int> countProblemsByTag({required String currentTagId});

  /// Filters and retrieves problems holding both [tagId] and [typeId].
  ///
  /// Pass [userId] optionally to establish the upvote context.
  Future<List<ProblemEntity>> getProblemsByTagAndType({
    required String tagId,
    required String typeId,
    String? userId,
  });

  /// Filters and retrieves problems strictly matching the provided [tagId].
  ///
  /// Supply [userId] optionally to establish the upvote context.
  Future<List<ProblemEntity>> getProblemsByTag({required String tagId, String? userId});

  /// Filters and retrieves problems strictly matching the provided [typeId].
  ///
  /// Supply [userId] optionally to establish the upvote context.
  Future<List<ProblemEntity>> getProblemsByType({required String typeId, String? userId});

  /// Registers an upvote for [id] authored by the requesting [userId].
  ///
  /// Side effects:
  /// Increments the upvote count and links the user with the target problem.
  Future<void> addUpvote({required String id, required String userId});

  /// Removes a previously registered upvote originally cast by [userId] on [id].
  ///
  /// Side effects:
  /// Decrements the overall upvote count and removes the explicit relation.
  Future<void> removeUpvote({required String id, required String userId});

  /// Finds and returns the single problem holding the highest number of upvotes.
  ///
  /// Uses [userId] to denote if the caller was part of the problem's voting pool.
  Future<ProblemEntity> getMaxUpvotedProblem(String userId);

  /// Retrieves problems that were exclusively reported by [reporterId].
  ///
  /// Required [currentUserId] determines vote statuses for the resulting list.
  Future<List<ProblemEntity>> getProblemsByReporter({
    required String reporterId,
    required String currentUserId,
  });
}
