part of 'generated.dart';

class ListProblemTypesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListProblemTypesVariablesBuilder(this._dataConnect, );
  Deserializer<ListProblemTypesData> dataDeserializer = (dynamic json)  => ListProblemTypesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListProblemTypesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListProblemTypesData, void> ref() {
    
    return _dataConnect.query("ListProblemTypes", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListProblemTypesProblemTypes {
  final String problemTypeId;
  final String typeName;
  final String typeThaiName;
  ListProblemTypesProblemTypes.fromJson(dynamic json):
  
  problemTypeId = nativeFromJson<String>(json['problemTypeId']),
  typeName = nativeFromJson<String>(json['typeName']),
  typeThaiName = nativeFromJson<String>(json['typeThaiName']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemTypesProblemTypes otherTyped = other as ListProblemTypesProblemTypes;
    return problemTypeId == otherTyped.problemTypeId && 
    typeName == otherTyped.typeName && 
    typeThaiName == otherTyped.typeThaiName;
    
  }
  @override
  int get hashCode => Object.hashAll([problemTypeId.hashCode, typeName.hashCode, typeThaiName.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemTypeId'] = nativeToJson<String>(problemTypeId);
    json['typeName'] = nativeToJson<String>(typeName);
    json['typeThaiName'] = nativeToJson<String>(typeThaiName);
    return json;
  }

  ListProblemTypesProblemTypes({
    required this.problemTypeId,
    required this.typeName,
    required this.typeThaiName,
  });
}

@immutable
class ListProblemTypesData {
  final List<ListProblemTypesProblemTypes> problemTypes;
  ListProblemTypesData.fromJson(dynamic json):
  
  problemTypes = (json['problemTypes'] as List<dynamic>)
        .map((e) => ListProblemTypesProblemTypes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemTypesData otherTyped = other as ListProblemTypesData;
    return problemTypes == otherTyped.problemTypes;
    
  }
  @override
  int get hashCode => problemTypes.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemTypes'] = problemTypes.map((e) => e.toJson()).toList();
    return json;
  }

  ListProblemTypesData({
    required this.problemTypes,
  });
}

