part of 'generated.dart';

class CreateProblemVariablesBuilder {
  String title;
  String detail;
  String locationName;
  double lat;
  double lng;
  String reporterId;
  String typeId;
  String tagId;

  final FirebaseDataConnect _dataConnect;
  CreateProblemVariablesBuilder(this._dataConnect, {required  this.title,required  this.detail,required  this.locationName,required  this.lat,required  this.lng,required  this.reporterId,required  this.typeId,required  this.tagId,});
  Deserializer<CreateProblemData> dataDeserializer = (dynamic json)  => CreateProblemData.fromJson(jsonDecode(json));
  Serializer<CreateProblemVariables> varsSerializer = (CreateProblemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateProblemData, CreateProblemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateProblemData, CreateProblemVariables> ref() {
    CreateProblemVariables vars= CreateProblemVariables(title: title,detail: detail,locationName: locationName,lat: lat,lng: lng,reporterId: reporterId,typeId: typeId,tagId: tagId,);
    return _dataConnect.mutation("CreateProblem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateProblemProblemInsert {
  final String problemId;
  CreateProblemProblemInsert.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProblemProblemInsert otherTyped = other as CreateProblemProblemInsert;
    return problemId == otherTyped.problemId;
    
  }
  @override
  int get hashCode => problemId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    return json;
  }

  CreateProblemProblemInsert({
    required this.problemId,
  });
}

@immutable
class CreateProblemData {
  final CreateProblemProblemInsert problem_insert;
  CreateProblemData.fromJson(dynamic json):
  
  problem_insert = CreateProblemProblemInsert.fromJson(json['problem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProblemData otherTyped = other as CreateProblemData;
    return problem_insert == otherTyped.problem_insert;
    
  }
  @override
  int get hashCode => problem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problem_insert'] = problem_insert.toJson();
    return json;
  }

  CreateProblemData({
    required this.problem_insert,
  });
}

@immutable
class CreateProblemVariables {
  final String title;
  final String detail;
  final String locationName;
  final double lat;
  final double lng;
  final String reporterId;
  final String typeId;
  final String tagId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateProblemVariables.fromJson(Map<String, dynamic> json):
  
  title = nativeFromJson<String>(json['title']),
  detail = nativeFromJson<String>(json['detail']),
  locationName = nativeFromJson<String>(json['locationName']),
  lat = nativeFromJson<double>(json['lat']),
  lng = nativeFromJson<double>(json['lng']),
  reporterId = nativeFromJson<String>(json['reporterId']),
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

    final CreateProblemVariables otherTyped = other as CreateProblemVariables;
    return title == otherTyped.title && 
    detail == otherTyped.detail && 
    locationName == otherTyped.locationName && 
    lat == otherTyped.lat && 
    lng == otherTyped.lng && 
    reporterId == otherTyped.reporterId && 
    typeId == otherTyped.typeId && 
    tagId == otherTyped.tagId;
    
  }
  @override
  int get hashCode => Object.hashAll([title.hashCode, detail.hashCode, locationName.hashCode, lat.hashCode, lng.hashCode, reporterId.hashCode, typeId.hashCode, tagId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['title'] = nativeToJson<String>(title);
    json['detail'] = nativeToJson<String>(detail);
    json['locationName'] = nativeToJson<String>(locationName);
    json['lat'] = nativeToJson<double>(lat);
    json['lng'] = nativeToJson<double>(lng);
    json['reporterId'] = nativeToJson<String>(reporterId);
    json['typeId'] = nativeToJson<String>(typeId);
    json['tagId'] = nativeToJson<String>(tagId);
    return json;
  }

  CreateProblemVariables({
    required this.title,
    required this.detail,
    required this.locationName,
    required this.lat,
    required this.lng,
    required this.reporterId,
    required this.typeId,
    required this.tagId,
  });
}

