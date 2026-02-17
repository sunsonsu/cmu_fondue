part of 'generated.dart';

class UpdateProblemImageVariablesBuilder {
  String problemImageId;
  String problemId;
  Optional<String> _imageUrl = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _fileName = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _imageType = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateProblemImageVariablesBuilder imageUrl(String? t) {
   _imageUrl.value = t;
   return this;
  }
  UpdateProblemImageVariablesBuilder fileName(String? t) {
   _fileName.value = t;
   return this;
  }
  UpdateProblemImageVariablesBuilder imageType(String? t) {
   _imageType.value = t;
   return this;
  }

  UpdateProblemImageVariablesBuilder(this._dataConnect, {required  this.problemImageId,required  this.problemId,});
  Deserializer<UpdateProblemImageData> dataDeserializer = (dynamic json)  => UpdateProblemImageData.fromJson(jsonDecode(json));
  Serializer<UpdateProblemImageVariables> varsSerializer = (UpdateProblemImageVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateProblemImageData, UpdateProblemImageVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateProblemImageData, UpdateProblemImageVariables> ref() {
    UpdateProblemImageVariables vars= UpdateProblemImageVariables(problemImageId: problemImageId,problemId: problemId,imageUrl: _imageUrl,fileName: _fileName,imageType: _imageType,);
    return _dataConnect.mutation("UpdateProblemImage", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateProblemImageProblemImageUpdate {
  final String problemImageId;
  UpdateProblemImageProblemImageUpdate.fromJson(dynamic json):
  
  problemImageId = nativeFromJson<String>(json['problemImageId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateProblemImageProblemImageUpdate otherTyped = other as UpdateProblemImageProblemImageUpdate;
    return problemImageId == otherTyped.problemImageId;
    
  }
  @override
  int get hashCode => problemImageId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemImageId'] = nativeToJson<String>(problemImageId);
    return json;
  }

  UpdateProblemImageProblemImageUpdate({
    required this.problemImageId,
  });
}

@immutable
class UpdateProblemImageData {
  final UpdateProblemImageProblemImageUpdate? problemImage_update;
  UpdateProblemImageData.fromJson(dynamic json):
  
  problemImage_update = json['problemImage_update'] == null ? null : UpdateProblemImageProblemImageUpdate.fromJson(json['problemImage_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateProblemImageData otherTyped = other as UpdateProblemImageData;
    return problemImage_update == otherTyped.problemImage_update;
    
  }
  @override
  int get hashCode => problemImage_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (problemImage_update != null) {
      json['problemImage_update'] = problemImage_update!.toJson();
    }
    return json;
  }

  UpdateProblemImageData({
    this.problemImage_update,
  });
}

@immutable
class UpdateProblemImageVariables {
  final String problemImageId;
  final String problemId;
  late final Optional<String>imageUrl;
  late final Optional<String>fileName;
  late final Optional<String>imageType;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateProblemImageVariables.fromJson(Map<String, dynamic> json):
  
  problemImageId = nativeFromJson<String>(json['problemImageId']),
  problemId = nativeFromJson<String>(json['problemId']) {
  
  
  
  
    imageUrl = Optional.optional(nativeFromJson, nativeToJson);
    imageUrl.value = json['imageUrl'] == null ? null : nativeFromJson<String>(json['imageUrl']);
  
  
    fileName = Optional.optional(nativeFromJson, nativeToJson);
    fileName.value = json['fileName'] == null ? null : nativeFromJson<String>(json['fileName']);
  
  
    imageType = Optional.optional(nativeFromJson, nativeToJson);
    imageType.value = json['imageType'] == null ? null : nativeFromJson<String>(json['imageType']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateProblemImageVariables otherTyped = other as UpdateProblemImageVariables;
    return problemImageId == otherTyped.problemImageId && 
    problemId == otherTyped.problemId && 
    imageUrl == otherTyped.imageUrl && 
    fileName == otherTyped.fileName && 
    imageType == otherTyped.imageType;
    
  }
  @override
  int get hashCode => Object.hashAll([problemImageId.hashCode, problemId.hashCode, imageUrl.hashCode, fileName.hashCode, imageType.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemImageId'] = nativeToJson<String>(problemImageId);
    json['problemId'] = nativeToJson<String>(problemId);
    if(imageUrl.state == OptionalState.set) {
      json['imageUrl'] = imageUrl.toJson();
    }
    if(fileName.state == OptionalState.set) {
      json['fileName'] = fileName.toJson();
    }
    if(imageType.state == OptionalState.set) {
      json['imageType'] = imageType.toJson();
    }
    return json;
  }

  UpdateProblemImageVariables({
    required this.problemImageId,
    required this.problemId,
    required this.imageUrl,
    required this.fileName,
    required this.imageType,
  });
}

