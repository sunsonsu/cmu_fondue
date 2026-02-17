part of 'generated.dart';

class CreateProblemImageVariablesBuilder {
  String problemId;
  String imageUrl;
  String fileName;
  String imageType;

  final FirebaseDataConnect _dataConnect;
  CreateProblemImageVariablesBuilder(this._dataConnect, {required  this.problemId,required  this.imageUrl,required  this.fileName,required  this.imageType,});
  Deserializer<CreateProblemImageData> dataDeserializer = (dynamic json)  => CreateProblemImageData.fromJson(jsonDecode(json));
  Serializer<CreateProblemImageVariables> varsSerializer = (CreateProblemImageVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateProblemImageData, CreateProblemImageVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateProblemImageData, CreateProblemImageVariables> ref() {
    CreateProblemImageVariables vars= CreateProblemImageVariables(problemId: problemId,imageUrl: imageUrl,fileName: fileName,imageType: imageType,);
    return _dataConnect.mutation("CreateProblemImage", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateProblemImageProblemImageInsert {
  final String problemImageId;
  CreateProblemImageProblemImageInsert.fromJson(dynamic json):
  
  problemImageId = nativeFromJson<String>(json['problemImageId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProblemImageProblemImageInsert otherTyped = other as CreateProblemImageProblemImageInsert;
    return problemImageId == otherTyped.problemImageId;
    
  }
  @override
  int get hashCode => problemImageId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemImageId'] = nativeToJson<String>(problemImageId);
    return json;
  }

  CreateProblemImageProblemImageInsert({
    required this.problemImageId,
  });
}

@immutable
class CreateProblemImageData {
  final CreateProblemImageProblemImageInsert problemImage_insert;
  CreateProblemImageData.fromJson(dynamic json):
  
  problemImage_insert = CreateProblemImageProblemImageInsert.fromJson(json['problemImage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProblemImageData otherTyped = other as CreateProblemImageData;
    return problemImage_insert == otherTyped.problemImage_insert;
    
  }
  @override
  int get hashCode => problemImage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemImage_insert'] = problemImage_insert.toJson();
    return json;
  }

  CreateProblemImageData({
    required this.problemImage_insert,
  });
}

@immutable
class CreateProblemImageVariables {
  final String problemId;
  final String imageUrl;
  final String fileName;
  final String imageType;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateProblemImageVariables.fromJson(Map<String, dynamic> json):
  
  problemId = nativeFromJson<String>(json['problemId']),
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  fileName = nativeFromJson<String>(json['fileName']),
  imageType = nativeFromJson<String>(json['imageType']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProblemImageVariables otherTyped = other as CreateProblemImageVariables;
    return problemId == otherTyped.problemId && 
    imageUrl == otherTyped.imageUrl && 
    fileName == otherTyped.fileName && 
    imageType == otherTyped.imageType;
    
  }
  @override
  int get hashCode => Object.hashAll([problemId.hashCode, imageUrl.hashCode, fileName.hashCode, imageType.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    json['fileName'] = nativeToJson<String>(fileName);
    json['imageType'] = nativeToJson<String>(imageType);
    return json;
  }

  CreateProblemImageVariables({
    required this.problemId,
    required this.imageUrl,
    required this.fileName,
    required this.imageType,
  });
}

