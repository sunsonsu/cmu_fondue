import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_repo.dart';

class GetProblemByIdUseCase {
  final ProblemRepo repository;

  GetProblemByIdUseCase(this.repository);

  Future<ProblemEntity?> call({
    required String problemId,
    String? userId,
  }) async {
    try {
      // ดึงข้อมูลทั้งหมดแล้วหา problem ที่ต้องการ
      final problems = await repository.getProblems(userId ?? '');
      return problems.firstWhere(
        (p) => p.id == problemId,
        orElse: () => throw Exception('Problem not found'),
      );
    } catch (e) {
      return null;
    }
  }
}
