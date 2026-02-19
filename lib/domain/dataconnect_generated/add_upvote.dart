part of 'generated.dart';

class AddUpvoteVariablesBuilder {
  String problemId;

  final FirebaseDataConnect _dataConnect;
  AddUpvoteVariablesBuilder(this._dataConnect, {required  this.problemId,});
  Deserializer<AddUpvoteData> dataDeserializer = (dynamic json)  => AddUpvoteData.fromJson(jsonDecode(json));
  Serializer<AddUpvoteVariables> varsSerializer = (AddUpvoteVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddUpvoteData, AddUpvoteVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddUpvoteData, AddUpvoteVariables> ref() {
    AddUpvoteVariables vars= AddUpvoteVariables(problemId: problemId,);
    return _dataConnect.mutation("AddUpvote", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddUpvoteUserUpvoteInsert {
  final String userId;
  final String problemId;
  AddUpvoteUserUpvoteInsert.fromJson(dynamic json):
  
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

    final AddUpvoteUserUpvoteInsert otherTyped = other as AddUpvoteUserUpvoteInsert;
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

  AddUpvoteUserUpvoteInsert({
    required this.userId,
    required this.problemId,
  });
}

@immutable
class AddUpvoteProblemUpdate {
  final String problemId;
  AddUpvoteProblemUpdate.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddUpvoteProblemUpdate otherTyped = other as AddUpvoteProblemUpdate;
    return problemId == otherTyped.problemId;
    
  }
  @override
  int get hashCode => problemId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    return json;
  }

  AddUpvoteProblemUpdate({
    required this.problemId,
  });
}

@immutable
class AddUpvoteData {
  final AddUpvoteUserUpvoteInsert userUpvote_insert;
  final AddUpvoteProblemUpdate? problem_update;
  AddUpvoteData.fromJson(dynamic json):
  
  userUpvote_insert = AddUpvoteUserUpvoteInsert.fromJson(json['userUpvote_insert']),
  problem_update = json['problem_update'] == null ? null : AddUpvoteProblemUpdate.fromJson(json['problem_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddUpvoteData otherTyped = other as AddUpvoteData;
    return userUpvote_insert == otherTyped.userUpvote_insert && 
    problem_update == otherTyped.problem_update;
    
  }
  @override
  int get hashCode => Object.hashAll([userUpvote_insert.hashCode, problem_update.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userUpvote_insert'] = userUpvote_insert.toJson();
    if (problem_update != null) {
      json['problem_update'] = problem_update!.toJson();
    }
    return json;
  }

  AddUpvoteData({
    required this.userUpvote_insert,
    this.problem_update,
  });
}

@immutable
class AddUpvoteVariables {
  final String problemId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddUpvoteVariables.fromJson(Map<String, dynamic> json):
  
  problemId = nativeFromJson<String>(json['problemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddUpvoteVariables otherTyped = other as AddUpvoteVariables;
    return problemId == otherTyped.problemId;
    
  }
  @override
  int get hashCode => problemId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    return json;
  }

  AddUpvoteVariables({
    required this.problemId,
  });
}

