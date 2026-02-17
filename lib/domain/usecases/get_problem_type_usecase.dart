import '../entities/problem_type_entity.dart';
import '../repositories/problem_type_repo.dart';

// Komsan
class GetProblemTypesUseCase {
  final ProblemTypeRepo repository;

  GetProblemTypesUseCase(this.repository);

  Future<List<ProblemTypeEntity>> call() async {
    return await repository.getProblemTypes();
  }
}