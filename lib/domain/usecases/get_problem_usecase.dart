/*
 * File: get_problem_usecase.dart
 * Description: Use case aggregating broad queries involving multiple problem instances.
 * Responsibilities: Handles listing problems, querying by tags or types, counting constraints, and determining maximum upvote holders.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import '../repositories/problem_repo.dart';

/// Coordinates multiple large-scale reporting tasks covering general problem queries.
class GetProblemsUseCase {
  /// The underlying repository handling query delegation.
  final ProblemRepo repository;

  /// Initializes a new instance of [GetProblemsUseCase].
  GetProblemsUseCase(this.repository);

  /// Fetches an exhaustive list of recorded problem issues.
  ///
  /// This operates asynchronously. Contextualizes the results against the passed [userId].
  Future<List<ProblemEntity>> call(String? userId) async {
    List<ProblemEntity> listProblems = await repository.getProblems(userId ?? '');
    return listProblems;
  }

  /// Requests problems whose states indicate they require further work.
  ///
  /// This operates asynchronously, factoring the interacting [userId].
  Future<List<ProblemEntity>> getNotCompletedProblems(String? userId) async {
    return await repository.getNotCompletedProblems(userId ?? '');
  }

  /// Obtains the raw integer tally of current problems possessing [currentTagId].
  ///
  /// This operates asynchronously.
  Future<int> countByTag(String currentTagId) async {
    return await repository.countProblemsByTag(currentTagId: currentTagId);
  }

  /// Extracts problems that mutually satisfy both [tagId] and [typeId].
  ///
  /// This operates asynchronously.
  Future<List<ProblemEntity>> getProblemsByTagAndType({
    required String tagId,
    required String typeId,
  }) async {
    return await repository.getProblemsByTagAndType(
      tagId: tagId,
      typeId: typeId,
    );
  }

  /// Computes a list restricted strictly to items matching the [tagId].
  ///
  /// This operates asynchronously.
  Future<List<ProblemEntity>> getProblemsByTag({required String tagId}) async {
    return await repository.getProblemsByTag(tagId: tagId);
  }

  /// Computes a list restricted strictly to items matching the [typeId].
  ///
  /// This operates asynchronously.
  Future<List<ProblemEntity>> getProblemsByType({
    required String typeId,
  }) async {
    return await repository.getProblemsByType(typeId: typeId);
  }

  /// Searches the database to identify the single most upvoted post contexted by [userId].
  ///
  /// This operates asynchronously.
  Future<ProblemEntity> getMaxUpvotedProblem(String? userId) async {
    return await repository.getMaxUpvotedProblem(userId ?? '');
  }
}
