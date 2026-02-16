part of 'generated.dart';

class DeleteProblemVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteProblemVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteProblemData> dataDeserializer = (dynamic json)  => DeleteProblemData.fromJson(jsonDecode(json));
  Serializer<DeleteProblemVariables> varsSerializer = (DeleteProblemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteProblemData, DeleteProblemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteProblemData, DeleteProblemVariables> ref() {
    DeleteProblemVariables vars= DeleteProblemVariables(id: id,);
    return _dataConnect.mutation("DeleteProblem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteProblemProblemDelete {
  final String problemId;
  DeleteProblemProblemDelete.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteProblemProblemDelete otherTyped = other as DeleteProblemProblemDelete;
    return problemId == otherTyped.problemId;
    
  }
  @override
  int get hashCode => problemId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    return json;
  }

  DeleteProblemProblemDelete({
    required this.problemId,
  });
}

@immutable
class DeleteProblemData {
  final DeleteProblemProblemDelete? problem_delete;
  DeleteProblemData.fromJson(dynamic json):
  
  problem_delete = json['problem_delete'] == null ? null : DeleteProblemProblemDelete.fromJson(json['problem_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteProblemData otherTyped = other as DeleteProblemData;
    return problem_delete == otherTyped.problem_delete;
    
  }
  @override
  int get hashCode => problem_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (problem_delete != null) {
      json['problem_delete'] = problem_delete!.toJson();
    }
    return json;
  }

  DeleteProblemData({
    this.problem_delete,
  });
}

@immutable
class DeleteProblemVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteProblemVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteProblemVariables otherTyped = other as DeleteProblemVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteProblemVariables({
    required this.id,
  });
}

