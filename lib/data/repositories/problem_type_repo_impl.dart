import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_type_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_type_repo.dart';

class ProblemTypeRepoImpl implements ProblemTypeRepo {

  final ConnectorConnector connector;
  ProblemTypeRepoImpl({required this.connector});

  @override
  Future<List<ProblemTypeEntity>> getProblemTypes() async{
    final result = await connector.listProblemTypes().execute();
    return result.data.problemTypes.map((e) => ProblemTypeEntity.fromGenerated(e)).toList();
  }
}