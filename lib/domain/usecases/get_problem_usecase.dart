import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import '../repositories/problem_repo.dart';

// Komsan
class GetProblemsUseCase {
  final ProblemRepo repository;
  GetProblemsUseCase(this.repository);

  Future<List<ProblemEntity>> call() async {
    List<ProblemEntity> list_problems = await repository.getProblems();
    print('=============${list_problems.length}================');
    return list_problems;
  }

  Future<List<ProblemEntity>> getNotCompletedProblems() async {
    return await repository.getNotCompletedProblems();
  }

  Future<int> countByTag(String currentTagId) async {
    return await repository.countProblemsByTag(currentTagId: currentTagId);
  }

  Future<List<ProblemEntity>> getProblemsByTagAndType({
    required String tagId,
    required String typeId,
  }) async {
    return await repository.getProblemsByTagAndType(
      tagId: tagId,
      typeId: typeId,
    );
  }

  Future<List<ProblemEntity>> getProblemsByTag({required String tagId}) async {
    return await repository.getProblemsByTag(tagId: tagId);
  }

  Future<List<ProblemEntity>> getProblemsByType({
    required String typeId,
  }) async {
    return await repository.getProblemsByType(typeId: typeId);
  }
}
