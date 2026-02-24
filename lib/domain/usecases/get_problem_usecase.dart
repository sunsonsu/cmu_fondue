import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import '../repositories/problem_repo.dart';

// Komsan
class GetProblemsUseCase {
  final ProblemRepo repository;
  GetProblemsUseCase(this.repository);

  Future<List<ProblemEntity>> call(String? userId) async {
    List<ProblemEntity> listProblems = await repository.getProblems(userId ?? '');
    return listProblems;
  }

  Future<List<ProblemEntity>> getNotCompletedProblems(String? userId) async {
    print("======================Get Problems without Completed by User: ${userId}==============================");
    return await repository.getNotCompletedProblems(userId ?? '');
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
