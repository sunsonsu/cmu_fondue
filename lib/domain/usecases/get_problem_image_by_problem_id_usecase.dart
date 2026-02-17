import 'package:cmu_fondue/domain/entities/problem_image_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_image_repo.dart';


// Komsan
class GetProblemImagesByProblemIdUseCase {

  final ProblemImageRepo repository;
  GetProblemImagesByProblemIdUseCase(this.repository);

  Future<List<ProblemImageEntity>> call(String problemId) async {
    return await repository.getProblemImageByProblemId(problemId);
  }
}