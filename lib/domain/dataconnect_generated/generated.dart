library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_problem.dart';

part 'update_problem.dart';

part 'delete_problem.dart';

part 'insert_problem_type.dart';

part 'insert_user.dart';

part 'create_problem_image.dart';

part 'update_problem_image.dart';

part 'delete_problem_image.dart';

part 'update_fcm_token.dart';

part 'add_upvote.dart';

part 'remove_upvote.dart';

part 'list_problems.dart';

part 'list_not_completed_problems.dart';

part 'list_problem_types.dart';

part 'list_problem_tags.dart';

part 'problem_types_query.dart';

part 'problem_image_by_problem_id.dart';

part 'problems_by_tag.dart';

part 'problems_by_tag_and_type.dart';

part 'problems_by_tag_full.dart';

part 'problems_by_type_full.dart';







class ConnectorConnector {
  
  
  CreateProblemVariablesBuilder createProblem ({required String title, required String detail, required String locationName, required double lat, required double lng, required String reporterId, required String typeId, required String tagId, }) {
    return CreateProblemVariablesBuilder(dataConnect, title: title,detail: detail,locationName: locationName,lat: lat,lng: lng,reporterId: reporterId,typeId: typeId,tagId: tagId,);
  }
  
  
  UpdateProblemVariablesBuilder updateProblem ({required String id, }) {
    return UpdateProblemVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeleteProblemVariablesBuilder deleteProblem ({required String id, }) {
    return DeleteProblemVariablesBuilder(dataConnect, id: id,);
  }
  
  
  InsertProblemTypeVariablesBuilder insertProblemType ({required String name, required String description, }) {
    return InsertProblemTypeVariablesBuilder(dataConnect, name: name,description: description,);
  }
  
  
  InsertUserVariablesBuilder insertUser ({required String email, required bool isAdmin, }) {
    return InsertUserVariablesBuilder(dataConnect, email: email,isAdmin: isAdmin,);
  }
  
  
  CreateProblemImageVariablesBuilder createProblemImage ({required String problemId, required String imageUrl, required String fileName, required String imageType, }) {
    return CreateProblemImageVariablesBuilder(dataConnect, problemId: problemId,imageUrl: imageUrl,fileName: fileName,imageType: imageType,);
  }
  
  
  UpdateProblemImageVariablesBuilder updateProblemImage ({required String problemImageId, required String problemId, }) {
    return UpdateProblemImageVariablesBuilder(dataConnect, problemImageId: problemImageId,problemId: problemId,);
  }
  
  
  DeleteProblemImageVariablesBuilder deleteProblemImage ({required String problemImageId, }) {
    return DeleteProblemImageVariablesBuilder(dataConnect, problemImageId: problemImageId,);
  }
  
  
  UpdateFcmTokenVariablesBuilder updateFcmToken ({required String userId, required String fcmToken, }) {
    return UpdateFcmTokenVariablesBuilder(dataConnect, userId: userId,fcmToken: fcmToken,);
  }
  
  
  AddUpvoteVariablesBuilder addUpvote ({required String problemId, }) {
    return AddUpvoteVariablesBuilder(dataConnect, problemId: problemId,);
  }
  
  
  RemoveUpvoteVariablesBuilder removeUpvote ({required String problemId, }) {
    return RemoveUpvoteVariablesBuilder(dataConnect, problemId: problemId,);
  }
  
  
  ListProblemsVariablesBuilder listProblems () {
    return ListProblemsVariablesBuilder(dataConnect, );
  }
  
  
  ListNotCompletedProblemsVariablesBuilder listNotCompletedProblems () {
    return ListNotCompletedProblemsVariablesBuilder(dataConnect, );
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
  
  
  ProblemImageByProblemIdVariablesBuilder problemImageByProblemId ({required String problemId, }) {
    return ProblemImageByProblemIdVariablesBuilder(dataConnect, problemId: problemId,);
  }
  
  
  ProblemsByTagVariablesBuilder problemsByTag ({required String TagId, }) {
    return ProblemsByTagVariablesBuilder(dataConnect, TagId: TagId,);
  }
  
  
  ProblemsByTagAndTypeVariablesBuilder problemsByTagAndType ({required String TagId, required String TypeId, }) {
    return ProblemsByTagAndTypeVariablesBuilder(dataConnect, TagId: TagId,TypeId: TypeId,);
  }
  
  
  ProblemsByTagFullVariablesBuilder problemsByTagFull ({required String TagId, }) {
    return ProblemsByTagFullVariablesBuilder(dataConnect, TagId: TagId,);
  }
  
  
  ProblemsByTypeFullVariablesBuilder problemsByTypeFull ({required String TypeId, }) {
    return ProblemsByTypeFullVariablesBuilder(dataConnect, TypeId: TypeId,);
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
