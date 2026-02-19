part of 'generated.dart';

class UpdateProblemVariablesBuilder {
  String id;
  Optional<String> _title = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _detail = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _locationName = Optional.optional(nativeFromJson, nativeToJson);
  Optional<double> _lat = Optional.optional(nativeFromJson, nativeToJson);
  Optional<double> _lng = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _typeId = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _tagId = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateProblemVariablesBuilder title(String? t) {
   _title.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder detail(String? t) {
   _detail.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder locationName(String? t) {
   _locationName.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder lat(double? t) {
   _lat.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder lng(double? t) {
   _lng.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder typeId(String? t) {
   _typeId.value = t;
   return this;
  }
  UpdateProblemVariablesBuilder tagId(String? t) {
   _tagId.value = t;
   return this;
  }

  UpdateProblemVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateProblemData> dataDeserializer = (dynamic json)  => UpdateProblemData.fromJson(jsonDecode(json));
  Serializer<UpdateProblemVariables> varsSerializer = (UpdateProblemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateProblemData, UpdateProblemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateProblemData, UpdateProblemVariables> ref() {
    UpdateProblemVariables vars= UpdateProblemVariables(id: id,title: _title,detail: _detail,locationName: _locationName,lat: _lat,lng: _lng,typeId: _typeId,tagId: _tagId,);
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
  late final Optional<String>title;
  late final Optional<String>detail;
  late final Optional<String>locationName;
  late final Optional<double>lat;
  late final Optional<double>lng;
  late final Optional<String>typeId;
  late final Optional<String>tagId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateProblemVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    title = Optional.optional(nativeFromJson, nativeToJson);
    title.value = json['title'] == null ? null : nativeFromJson<String>(json['title']);
  
  
    detail = Optional.optional(nativeFromJson, nativeToJson);
    detail.value = json['detail'] == null ? null : nativeFromJson<String>(json['detail']);
  
  
    locationName = Optional.optional(nativeFromJson, nativeToJson);
    locationName.value = json['locationName'] == null ? null : nativeFromJson<String>(json['locationName']);
  
  
    lat = Optional.optional(nativeFromJson, nativeToJson);
    lat.value = json['lat'] == null ? null : nativeFromJson<double>(json['lat']);
  
  
    lng = Optional.optional(nativeFromJson, nativeToJson);
    lng.value = json['lng'] == null ? null : nativeFromJson<double>(json['lng']);
  
  
    typeId = Optional.optional(nativeFromJson, nativeToJson);
    typeId.value = json['typeId'] == null ? null : nativeFromJson<String>(json['typeId']);
  
  
    tagId = Optional.optional(nativeFromJson, nativeToJson);
    tagId.value = json['tagId'] == null ? null : nativeFromJson<String>(json['tagId']);
  
  }
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
    locationName == otherTyped.locationName && 
    lat == otherTyped.lat && 
    lng == otherTyped.lng && 
    typeId == otherTyped.typeId && 
    tagId == otherTyped.tagId;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode, detail.hashCode, locationName.hashCode, lat.hashCode, lng.hashCode, typeId.hashCode, tagId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(title.state == OptionalState.set) {
      json['title'] = title.toJson();
    }
    if(detail.state == OptionalState.set) {
      json['detail'] = detail.toJson();
    }
    if(locationName.state == OptionalState.set) {
      json['locationName'] = locationName.toJson();
    }
    if(lat.state == OptionalState.set) {
      json['lat'] = lat.toJson();
    }
    if(lng.state == OptionalState.set) {
      json['lng'] = lng.toJson();
    }
    if(typeId.state == OptionalState.set) {
      json['typeId'] = typeId.toJson();
    }
    if(tagId.state == OptionalState.set) {
      json['tagId'] = tagId.toJson();
    }
    return json;
  }

  UpdateProblemVariables({
    required this.id,
    required this.title,
    required this.detail,
    required this.locationName,
    required this.lat,
    required this.lng,
    required this.typeId,
    required this.tagId,
  });
}

