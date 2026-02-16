library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'insert_problem_type.dart';

part 'insert_user.dart';

part 'create_problem.dart';

part 'update_problem.dart';

part 'delete_problem.dart';

part 'list_problems.dart';

part 'list_problem_types.dart';

part 'list_problem_tags.dart';

part 'problem_types_query.dart';







class ConnectorConnector {
  
  
  InsertProblemTypeVariablesBuilder insertProblemType ({required String name, required String description, }) {
    return InsertProblemTypeVariablesBuilder(dataConnect, name: name,description: description,);
  }
  
  
  InsertUserVariablesBuilder insertUser ({required String email, required bool isAdmin, }) {
    return InsertUserVariablesBuilder(dataConnect, email: email,isAdmin: isAdmin,);
  }
  
  
  CreateProblemVariablesBuilder createProblem ({required String title, required String detail, required double lat, required double lng, required String reporterId, required String typeId, required String tagId, }) {
    return CreateProblemVariablesBuilder(dataConnect, title: title,detail: detail,lat: lat,lng: lng,reporterId: reporterId,typeId: typeId,tagId: tagId,);
  }
  
  
  UpdateProblemVariablesBuilder updateProblem ({required String id, required String title, required String detail, required double lat, required double lng, required String typeId, required String tagId, }) {
    return UpdateProblemVariablesBuilder(dataConnect, id: id,title: title,detail: detail,lat: lat,lng: lng,typeId: typeId,tagId: tagId,);
  }
  
  
  DeleteProblemVariablesBuilder deleteProblem ({required String id, }) {
    return DeleteProblemVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListProblemsVariablesBuilder listProblems () {
    return ListProblemsVariablesBuilder(dataConnect, );
  }
  
  
  ListProblemTypesVariablesBuilder listProblemTypes () {
    return ListProblemTypesVariablesBuilder(dataConnect, );
  }
  
  
  ListProblemTagsVariablesBuilder listProblemTags () {
    return ListProblemTagsVariablesBuilder(dataConnect, );
  }
  
  
  ProblemTypesQueryVariablesBuilder problemTypesQuery () {
    return ProblemTypesQueryVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-southeast1',
    'connector',
    'cmu-fondue-service',
  );

  ConnectorConnector({required this.dataConnect});
  static ConnectorConnector get instance {
    return ConnectorConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
