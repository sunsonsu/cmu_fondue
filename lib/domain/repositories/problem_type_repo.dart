
import 'package:cmu_fondue/domain/entities/problem_type_entity.dart';
// Komsan
abstract class ProblemTypeRepo {
  Future<List<ProblemTypeEntity>> getProblemTypes();

}
