import 'package:cmu_fondue/domain/entities/problem_entity.dart';

abstract class ProblemRepo {
  //List all problems
  Future<List<ProblemEntity>> getProblems(String userId);

  Future<List<ProblemEntity>> getNotCompletedProblems(String userId);

  //Create a new problem
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

  //Update an existing problem
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

  //Delete a problem
  Future<void> deleteProblem(String id);

  // Count problems by tag
  Future<int> countProblemsByTag({required String currentTagId});

  Future<List<ProblemEntity>> getProblemsByTagAndType({
    required String tagId,
    required String typeId,
    String? userId,
  });

  Future<List<ProblemEntity>> getProblemsByTag({required String tagId, String? userId});

  Future<List<ProblemEntity>> getProblemsByType({required String typeId, String? userId});

  // Insert upvote
  Future<void> addUpvote({required String id, required String userId});

  // Delete upvote
  Future<void> removeUpvote({required String id, required String userId});

  Future<ProblemEntity> getMaxUpvotedProblem(String userId);

  // Get problems by reporter
  Future<List<ProblemEntity>> getProblemsByReporter({
    required String reporterId,
    required String currentUserId,
  });
}
