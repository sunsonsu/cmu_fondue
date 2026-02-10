part of 'generated.dart';

class UpdateProblemVariablesBuilder {
  String id;
  String title;
  String detail;
  double lat;
  double lng;
  String typeId;
  String tagId;

  final FirebaseDataConnect _dataConnect;
  UpdateProblemVariablesBuilder(this._dataConnect, {required  this.id,required  this.title,required  this.detail,required  this.lat,required  this.lng,required  this.typeId,required  this.tagId,});
  Deserializer<UpdateProblemData> dataDeserializer = (dynamic json)  => UpdateProblemData.fromJson(jsonDecode(json));
  Serializer<UpdateProblemVariables> varsSerializer = (UpdateProblemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateProblemData, UpdateProblemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateProblemData, UpdateProblemVariables> ref() {
    UpdateProblemVariables vars= UpdateProblemVariables(id: id,title: title,detail: detail,lat: lat,lng: lng,typeId: typeId,tagId: tagId,);
    return _dataConnect.mutation("UpdateProblem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateProblemProblemUpdate {
  final String problemId;
  UpdateProblemProblemUpdate.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateProblemProblemUpdate otherTyped = other as UpdateProblemProblemUpdate;
    return problemId == otherTyped.problemId;
    
  }
  @override
  int get hashCode => problemId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    return json;
  }

  UpdateProblemProblemUpdate({
    required this.problemId,
  });
}

@immutable
class UpdateProblemData {
  final UpdateProblemProblemUpdate? problem_update;
  UpdateProblemData.fromJson(dynamic json):
  
  problem_update = json['problem_update'] == null ? null : UpdateProblemProblemUpdate.fromJson(json['problem_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateProblemData otherTyped = other as UpdateProblemData;
    return problem_update == otherTyped.problem_update;
    
  }
  @override
  int get hashCode => problem_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (problem_update != null) {
      json['problem_update'] = problem_update!.toJson();
    }
    return json;
  }

  UpdateProblemData({
    this.problem_update,
  });
}

@immutable
class UpdateProblemVariables {
  final String id;
  final String title;
  final String detail;
  final double lat;
  final double lng;
  final String typeId;
  final String tagId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateProblemVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  title = nativeFromJson<String>(json['title']),
  detail = nativeFromJson<String>(json['detail']),
  lat = nativeFromJson<double>(json['lat']),
  lng = nativeFromJson<double>(json['lng']),
  typeId = nativeFromJson<String>(json['typeId']),
  tagId = nativeFromJson<String>(json['tagId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateProblemVariables otherTyped = other as UpdateProblemVariables;
    return id == otherTyped.id && 
    title == otherTyped.title && 
    detail == otherTyped.detail && 
    lat == otherTyped.lat && 
    lng == otherTyped.lng && 
    typeId == otherTyped.typeId && 
    tagId == otherTyped.tagId;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode, detail.hashCode, lat.hashCode, lng.hashCode, typeId.hashCode, tagId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['title'] = nativeToJson<String>(title);
    json['detail'] = nativeToJson<String>(detail);
    json['lat'] = nativeToJson<double>(lat);
    json['lng'] = nativeToJson<double>(lng);
    json['typeId'] = nativeToJson<String>(typeId);
    json['tagId'] = nativeToJson<String>(tagId);
    return json;
  }

  UpdateProblemVariables({
    required this.id,
    required this.title,
    required this.detail,
    required this.lat,
    required this.lng,
    required this.typeId,
    required this.tagId,
  });
}

