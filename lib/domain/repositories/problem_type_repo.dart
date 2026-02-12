
import 'package:cmu_fondue/domain/entities/problem_type_entity.dart';

abstract class ProblemTypeRepo {
  Future<List<ProblemTypeEntity>> getProblemTypes();

}
