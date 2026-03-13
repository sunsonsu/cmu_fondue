/*
 * File: problem_tag_repo_impl.dart
 * Description: Concrete implementation of the ProblemTagRepo.
 * Responsibilities: Performs read requests for system problem tags leveraging Data Connect SDK.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_tag_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_tag_repo.dart';

/// Implements domain constraints for problem tag categories utilizing Firebase Data Connect.
class ProblemTagRepoImpl implements ProblemTagRepo {
  /// The generated connector executing direct GraphQL queries.
  final ConnectorConnector connector;

  /// Initializes a new instance of [ProblemTagRepoImpl].
  ProblemTagRepoImpl({required this.connector});

  @override
  Future<List<ProblemTagEntity>> getAllProblemTags() async {
    final result = await connector.listProblemTags().execute();
    return result.data.problemTags.map((e) => ProblemTagEntity.fromGenerated(e)).toList();
  }

  @override
  Future<void> insertProblemTag() async {
    // Left intentionally unimplemented.
  }
}