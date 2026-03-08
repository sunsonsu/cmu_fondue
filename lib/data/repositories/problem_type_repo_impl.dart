/*
 * File: problem_type_repo_impl.dart
 * Description: Concrete implementation of the ProblemTypeRepo.
 * Responsibilities: Performs read requests for master problem type schemas leveraging the Data Connect SDK.
 * Author: Komsan
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_type_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_type_repo.dart';

/// Implements domain specifications for immutable problem categorizations utilizing Firebase Data Connect.
class ProblemTypeRepoImpl implements ProblemTypeRepo {
  /// The generated connector executing direct GraphQL queries.
  final ConnectorConnector connector;

  /// Initializes a new instance of [ProblemTypeRepoImpl].
  ProblemTypeRepoImpl({required this.connector});
  
  @override
  Future<List<ProblemTypeEntity>> getProblemTypes() async {
    final result = await connector.listProblemTypes().execute();
    return result.data.problemTypes.map((e) => ProblemTypeEntity.fromGenerated(e)).toList();
  }
}