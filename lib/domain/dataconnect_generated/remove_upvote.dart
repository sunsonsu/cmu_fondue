part of 'generated.dart';

class RemoveUpvoteVariablesBuilder {
  String problemId;
  String userId;

  final FirebaseDataConnect _dataConnect;
  RemoveUpvoteVariablesBuilder(this._dataConnect, {required  this.problemId,required  this.userId,});
  Deserializer<RemoveUpvoteData> dataDeserializer = (dynamic json)  => RemoveUpvoteData.fromJson(jsonDecode(json));
  Serializer<RemoveUpvoteVariables> varsSerializer = (RemoveUpvoteVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RemoveUpvoteData, RemoveUpvoteVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RemoveUpvoteData, RemoveUpvoteVariables> ref() {
    RemoveUpvoteVariables vars= RemoveUpvoteVariables(problemId: problemId,userId: userId,);
    return _dataConnect.mutation("RemoveUpvote", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class RemoveUpvoteUserUpvoteDelete {
  final String userId;
  final String problemId;
  RemoveUpvoteUserUpvoteDelete.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']),
  problemId = nativeFromJson<String>(json['problemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveUpvoteUserUpvoteDelete otherTyped = other as RemoveUpvoteUserUpvoteDelete;
    return userId == otherTyped.userId && 
    problemId == otherTyped.problemId;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, problemId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['problemId'] = nativeToJson<String>(problemId);
    return json;
  }

  RemoveUpvoteUserUpvoteDelete({
    required this.userId,
    required this.problemId,
  });
}

@immutable
class RemoveUpvoteProblemUpdate {
  final String problemId;
  RemoveUpvoteProblemUpdate.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveUpvoteProblemUpdate otherTyped = other as RemoveUpvoteProblemUpdate;
    return problemId == otherTyped.problemId;
    
  }
  @override
  int get hashCode => problemId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    return json;
  }

  RemoveUpvoteProblemUpdate({
    required this.problemId,
  });
}

@immutable
class RemoveUpvoteData {
  final RemoveUpvoteUserUpvoteDelete? userUpvote_delete;
  final RemoveUpvoteProblemUpdate? problem_update;
  RemoveUpvoteData.fromJson(dynamic json):
  
  userUpvote_delete = json['userUpvote_delete'] == null ? null : RemoveUpvoteUserUpvoteDelete.fromJson(json['userUpvote_delete']),
  problem_update = json['problem_update'] == null ? null : RemoveUpvoteProblemUpdate.fromJson(json['problem_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveUpvoteData otherTyped = other as RemoveUpvoteData;
    return userUpvote_delete == otherTyped.userUpvote_delete && 
    problem_update == otherTyped.problem_update;
    
  }
  @override
  int get hashCode => Object.hashAll([userUpvote_delete.hashCode, problem_update.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (userUpvote_delete != null) {
      json['userUpvote_delete'] = userUpvote_delete!.toJson();
    }
    if (problem_update != null) {
      json['problem_update'] = problem_update!.toJson();
    }
    return json;
  }

  RemoveUpvoteData({
    this.userUpvote_delete,
    this.problem_update,
  });
}

@immutable
class RemoveUpvoteVariables {
  final String problemId;
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RemoveUpvoteVariables.fromJson(Map<String, dynamic> json):
  
  problemId = nativeFromJson<String>(json['problemId']),
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveUpvoteVariables otherTyped = other as RemoveUpvoteVariables;
    return problemId == otherTyped.problemId && 
    userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => Object.hashAll([problemId.hashCode, userId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  RemoveUpvoteVariables({
    required this.problemId,
    required this.userId,
  });
}

