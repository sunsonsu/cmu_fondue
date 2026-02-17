import 'package:cmu_fondue/domain/entities/problem_entity.dart';

abstract class ProblemRepo {
  //List all problems
  Future<List<ProblemEntity>> getProblems();

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
}
