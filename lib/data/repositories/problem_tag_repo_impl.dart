import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_tag_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_tag_repo.dart';

class ProblemTagRepoImpl implements ProblemTagRepo {

  final ConnectorConnector connector;
  ProblemTagRepoImpl({required this.connector});

  @override
  Future<List<ProblemTagEntity>> getAllProblemTags() async{
    final result = await connector.listProblemTags().execute();
    return result.data.problemTags.map((e) => ProblemTagEntity.fromGenerated(e)).toList();
  }

  @override
  Future<void> insertProblemTag() async {
  }
}