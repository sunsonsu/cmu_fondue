import 'package:cmu_fondue/domain/entities/problem_entity.dart';

abstract class ProblemRepository {
  Future<List<ProblemEntity>> getProblemsNearby();
}
