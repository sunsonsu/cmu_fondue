part of 'generated.dart';

class ProblemImageByProblemIdVariablesBuilder {
  String problemId;

  final FirebaseDataConnect _dataConnect;
  ProblemImageByProblemIdVariablesBuilder(this._dataConnect, {required  this.problemId,});
  Deserializer<ProblemImageByProblemIdData> dataDeserializer = (dynamic json)  => ProblemImageByProblemIdData.fromJson(jsonDecode(json));
  Serializer<ProblemImageByProblemIdVariables> varsSerializer = (ProblemImageByProblemIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ProblemImageByProblemIdData, ProblemImageByProblemIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ProblemImageByProblemIdData, ProblemImageByProblemIdVariables> ref() {
    ProblemImageByProblemIdVariables vars= ProblemImageByProblemIdVariables(problemId: problemId,);
    return _dataConnect.query("ProblemImageByProblemId", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ProblemImageByProblemIdProblemImages {
  final String problemImageId;
  final String problemId;
  final String imageUrl;
  final String fileName;
  final String imageType;
  final Timestamp createdAt;
  ProblemImageByProblemIdProblemImages.fromJson(dynamic json):
  
  problemImageId = nativeFromJson<String>(json['problemImageId']),
  problemId = nativeFromJson<String>(json['problemId']),
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  fileName = nativeFromJson<String>(json['fileName']),
  imageType = nativeFromJson<String>(json['imageType']),
  createdAt = Timestamp.fromJson(json['createdAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemImageByProblemIdProblemImages otherTyped = other as ProblemImageByProblemIdProblemImages;
    return problemImageId == otherTyped.problemImageId && 
    problemId == otherTyped.problemId && 
    imageUrl == otherTyped.imageUrl && 
    fileName == otherTyped.fileName && 
    imageType == otherTyped.imageType && 
    createdAt == otherTyped.createdAt;
    
  }
  @override
  int get hashCode => Object.hashAll([problemImageId.hashCode, problemId.hashCode, imageUrl.hashCode, fileName.hashCode, imageType.hashCode, createdAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemImageId'] = nativeToJson<String>(problemImageId);
    json['problemId'] = nativeToJson<String>(problemId);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    json['fileName'] = nativeToJson<String>(fileName);
    json['imageType'] = nativeToJson<String>(imageType);
    json['createdAt'] = createdAt.toJson();
    return json;
  }

  ProblemImageByProblemIdProblemImages({
    required this.problemImageId,
    required this.problemId,
    required this.imageUrl,
    required this.fileName,
    required this.imageType,
    required this.createdAt,
  });
}

@immutable
class ProblemImageByProblemIdData {
  final List<ProblemImageByProblemIdProblemImages> problemImages;
  ProblemImageByProblemIdData.fromJson(dynamic json):
  
  problemImages = (json['problemImages'] as List<dynamic>)
        .map((e) => ProblemImageByProblemIdProblemImages.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemImageByProblemIdData otherTyped = other as ProblemImageByProblemIdData;
    return problemImages == otherTyped.problemImages;
    
  }
  @override
  int get hashCode => problemImages.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemImages'] = problemImages.map((e) => e.toJson()).toList();
    return json;
  }

  ProblemImageByProblemIdData({
    required this.problemImages,
  });
}

@immutable
class ProblemImageByProblemIdVariables {
  final String problemId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ProblemImageByProblemIdVariables.fromJson(Map<String, dynamic> json):
  
  problemId = nativeFromJson<String>(json['problemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemImageByProblemIdVariables otherTyped = other as ProblemImageByProblemIdVariables;
    return problemId == otherTyped.problemId;
    
  }
  @override
  int get hashCode => problemId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    return json;
  }

  ProblemImageByProblemIdVariables({
    required this.problemId,
  });
}

