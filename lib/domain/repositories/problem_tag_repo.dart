
import 'package:cmu_fondue/domain/entities/problem_tag_entity.dart';

abstract class ProblemTagRepo {
  // Get all Problem Tags
  Future<List<ProblemTagEntity>> getAllProblemTags();

  //Insert a new Problem tag
  Future<void> insertProblemTag();

}
