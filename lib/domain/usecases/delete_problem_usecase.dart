import '../repositories/problem_repo.dart';
  
// Komsan
class DeleteProblemUseCase {
  final ProblemRepo repository;
  DeleteProblemUseCase(this.repository);
  
  Future<void> call(String id) async {
    return await repository.deleteProblem(id);
  }
}