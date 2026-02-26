import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import '../repositories/problem_repo.dart';

class GetUserProblemsUseCase {
  final ProblemRepo repository;
  
  GetUserProblemsUseCase(this.repository);

  Future<List<ProblemEntity>> call({
    required String reporterId,
    required String currentUserId,
  }) async {
    return await repository.getProblemsByReporter(
      reporterId: reporterId,
      currentUserId: currentUserId,
    );
  }
}
