part of 'generated.dart';

class DeleteProblemImageVariablesBuilder {
  String problemImageId;

  final FirebaseDataConnect _dataConnect;
  DeleteProblemImageVariablesBuilder(this._dataConnect, {required  this.problemImageId,});
  Deserializer<DeleteProblemImageData> dataDeserializer = (dynamic json)  => DeleteProblemImageData.fromJson(jsonDecode(json));
  Serializer<DeleteProblemImageVariables> varsSerializer = (DeleteProblemImageVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteProblemImageData, DeleteProblemImageVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteProblemImageData, DeleteProblemImageVariables> ref() {
    DeleteProblemImageVariables vars= DeleteProblemImageVariables(problemImageId: problemImageId,);
    return _dataConnect.mutation("DeleteProblemImage", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteProblemImageProblemImageDelete {
  final String problemImageId;
  DeleteProblemImageProblemImageDelete.fromJson(dynamic json):
  
  problemImageId = nativeFromJson<String>(json['problemImageId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteProblemImageProblemImageDelete otherTyped = other as DeleteProblemImageProblemImageDelete;
    return problemImageId == otherTyped.problemImageId;
    
  }
  @override
  int get hashCode => problemImageId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemImageId'] = nativeToJson<String>(problemImageId);
    return json;
  }

  DeleteProblemImageProblemImageDelete({
    required this.problemImageId,
  });
}

@immutable
class DeleteProblemImageData {
  final DeleteProblemImageProblemImageDelete? problemImage_delete;
  DeleteProblemImageData.fromJson(dynamic json):
  
  problemImage_delete = json['problemImage_delete'] == null ? null : DeleteProblemImageProblemImageDelete.fromJson(json['problemImage_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteProblemImageData otherTyped = other as DeleteProblemImageData;
    return problemImage_delete == otherTyped.problemImage_delete;
    
  }
  @override
  int get hashCode => problemImage_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (problemImage_delete != null) {
      json['problemImage_delete'] = problemImage_delete!.toJson();
    }
    return json;
  }

  DeleteProblemImageData({
    this.problemImage_delete,
  });
}

@immutable
class DeleteProblemImageVariables {
  final String problemImageId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteProblemImageVariables.fromJson(Map<String, dynamic> json):
  
  problemImageId = nativeFromJson<String>(json['problemImageId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteProblemImageVariables otherTyped = other as DeleteProblemImageVariables;
    return problemImageId == otherTyped.problemImageId;
    
  }
  @override
  int get hashCode => problemImageId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemImageId'] = nativeToJson<String>(problemImageId);
    return json;
  }

  DeleteProblemImageVariables({
    required this.problemImageId,
  });
}

