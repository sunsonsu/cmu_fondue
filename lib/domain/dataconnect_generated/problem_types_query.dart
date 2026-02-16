part of 'generated.dart';

class ProblemTypesQueryVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ProblemTypesQueryVariablesBuilder(this._dataConnect, );
  Deserializer<ProblemTypesQueryData> dataDeserializer = (dynamic json)  => ProblemTypesQueryData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ProblemTypesQueryData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ProblemTypesQueryData, void> ref() {
    
    return _dataConnect.query("ProblemTypesQuery", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ProblemTypesQueryProblemTypes {
  final String typeName;
  final String typeThaiName;
  ProblemTypesQueryProblemTypes.fromJson(dynamic json):
  
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

    final ProblemTypesQueryProblemTypes otherTyped = other as ProblemTypesQueryProblemTypes;
    return typeName == otherTyped.typeName && 
    typeThaiName == otherTyped.typeThaiName;
    
  }
  @override
  int get hashCode => Object.hashAll([typeName.hashCode, typeThaiName.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['typeName'] = nativeToJson<String>(typeName);
    json['typeThaiName'] = nativeToJson<String>(typeThaiName);
    return json;
  }

  ProblemTypesQueryProblemTypes({
    required this.typeName,
    required this.typeThaiName,
  });
}

@immutable
class ProblemTypesQueryData {
  final List<ProblemTypesQueryProblemTypes> problemTypes;
  ProblemTypesQueryData.fromJson(dynamic json):
  
  problemTypes = (json['problemTypes'] as List<dynamic>)
        .map((e) => ProblemTypesQueryProblemTypes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemTypesQueryData otherTyped = other as ProblemTypesQueryData;
    return problemTypes == otherTyped.problemTypes;
    
  }
  @override
  int get hashCode => problemTypes.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemTypes'] = problemTypes.map((e) => e.toJson()).toList();
    return json;
  }

  ProblemTypesQueryData({
    required this.problemTypes,
  });
}

