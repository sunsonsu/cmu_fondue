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
class ProblemTypesQueryProblemTypess {
  final String typeName;
  final String typeThaiName;
  ProblemTypesQueryProblemTypess.fromJson(dynamic json):
  
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

    final ProblemTypesQueryProblemTypess otherTyped = other as ProblemTypesQueryProblemTypess;
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

  ProblemTypesQueryProblemTypess({
    required this.typeName,
    required this.typeThaiName,
  });
}

@immutable
class ProblemTypesQueryData {
  final List<ProblemTypesQueryProblemTypess> problemTypess;
  ProblemTypesQueryData.fromJson(dynamic json):
  
  problemTypess = (json['problemTypess'] as List<dynamic>)
        .map((e) => ProblemTypesQueryProblemTypess.fromJson(e))
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
    return problemTypess == otherTyped.problemTypess;
    
  }
  @override
  int get hashCode => problemTypess.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemTypess'] = problemTypess.map((e) => e.toJson()).toList();
    return json;
  }

  ProblemTypesQueryData({
    required this.problemTypess,
  });
}

