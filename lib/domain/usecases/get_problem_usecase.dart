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

  Future<List<ProblemEntity>> getNotDoneProblems() async {
    return await repository.getNotDoneProblems();
  }

  Future<int> countByTag(String currentTagId) async {
    return await repository.countProblemsByTag(currentTagId: currentTagId);
  }
}
