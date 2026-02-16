part of 'generated.dart';

class InsertProblemTypeVariablesBuilder {
  String name;
  String description;

  final FirebaseDataConnect _dataConnect;
  InsertProblemTypeVariablesBuilder(this._dataConnect, {required  this.name,required  this.description,});
  Deserializer<InsertProblemTypeData> dataDeserializer = (dynamic json)  => InsertProblemTypeData.fromJson(jsonDecode(json));
  Serializer<InsertProblemTypeVariables> varsSerializer = (InsertProblemTypeVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertProblemTypeData, InsertProblemTypeVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertProblemTypeData, InsertProblemTypeVariables> ref() {
    InsertProblemTypeVariables vars= InsertProblemTypeVariables(name: name,description: description,);
    return _dataConnect.mutation("insertProblemType", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertProblemTypeProblemTypeInsert {
  final String problemTypeId;
  InsertProblemTypeProblemTypeInsert.fromJson(dynamic json):
  
  problemTypeId = nativeFromJson<String>(json['problemTypeId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertProblemTypeProblemTypeInsert otherTyped = other as InsertProblemTypeProblemTypeInsert;
    return problemTypeId == otherTyped.problemTypeId;
    
  }
  @override
  int get hashCode => problemTypeId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemTypeId'] = nativeToJson<String>(problemTypeId);
    return json;
  }

  InsertProblemTypeProblemTypeInsert({
    required this.problemTypeId,
  });
}

@immutable
class InsertProblemTypeData {
  final InsertProblemTypeProblemTypeInsert problemType_insert;
  InsertProblemTypeData.fromJson(dynamic json):
  
  problemType_insert = InsertProblemTypeProblemTypeInsert.fromJson(json['problemType_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertProblemTypeData otherTyped = other as InsertProblemTypeData;
    return problemType_insert == otherTyped.problemType_insert;
    
  }
  @override
  int get hashCode => problemType_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemType_insert'] = problemType_insert.toJson();
    return json;
  }

  InsertProblemTypeData({
    required this.problemType_insert,
  });
}

@immutable
class InsertProblemTypeVariables {
  final String name;
  final String description;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertProblemTypeVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  description = nativeFromJson<String>(json['description']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertProblemTypeVariables otherTyped = other as InsertProblemTypeVariables;
    return name == otherTyped.name && 
    description == otherTyped.description;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, description.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    return json;
  }

  InsertProblemTypeVariables({
    required this.name,
    required this.description,
  });
}

