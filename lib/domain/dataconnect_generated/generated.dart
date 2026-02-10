library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'insert_problem_type.dart';

part 'insert_user.dart';

part 'problem_types_query.dart';







class ConnectorConnector {
  
  
  InsertProblemTypeVariablesBuilder insertProblemType ({required String name, required String description, }) {
    return InsertProblemTypeVariablesBuilder(dataConnect, name: name,description: description,);
  }
  
  
  InsertUserVariablesBuilder insertUser ({required String email, required bool isAdmin, }) {
    return InsertUserVariablesBuilder(dataConnect, email: email,isAdmin: isAdmin,);
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
