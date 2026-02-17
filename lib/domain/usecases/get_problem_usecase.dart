import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import '../repositories/problem_repo.dart';

// Komsan
class GetProblemsUseCase {
  final ProblemRepo repository;
  GetProblemsUseCase(this.repository);

  Future<List<ProblemEntity>> call() async {
    return await repository.getProblems();
  }
}