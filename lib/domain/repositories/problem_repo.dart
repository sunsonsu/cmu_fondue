import 'package:cmu_fondue/domain/entities/problem_entity.dart';

abstract class ProblemRepo {
  //List all problems
  Future<List<ProblemEntity>> getProblems();

  //Create a new problem
  Future<String> createProblem({
    required String title,
    required String detail,
    required double lat,
    required double lng,
    required String reporterId,
    required String typeId,
    required String tagId,
  });

  //Update an existing problem
  Future<void> updateProblem({
    required String id,
    required String title,
    required String detail,
    required double lat,
    required double lng,
    required String typeId,
    required String tagId,
  });

  //Delete a problem
  Future<void> deleteProblem(String id);
}
