part of 'generated.dart';

class VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  VariablesBuilder(this._dataConnect, );
  Deserializer<Data> dataDeserializer = (dynamic json)  => Data.fromJson(jsonDecode(json));
  
  Future<QueryResult<Data, void>> execute() {
    return ref().execute();
  }

  QueryRef<Data, void> ref() {
    
    return _dataConnect.query("", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ProblemTypess {
  final String typeName;
  final String typeThaiName;
  ProblemTypess.fromJson(dynamic json):
  
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

    final ProblemTypess otherTyped = other as ProblemTypess;
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

  ProblemTypess({
    required this.typeName,
    required this.typeThaiName,
  });
}

@immutable
class Data {
  final List<ProblemTypess> problemTypess;
  Data.fromJson(dynamic json):
  
  problemTypess = (json['problemTypess'] as List<dynamic>)
        .map((e) => ProblemTypess.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final Data otherTyped = other as Data;
    return problemTypess == otherTyped.problemTypess;
    
  }
  @override
  int get hashCode => problemTypess.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemTypess'] = problemTypess.map((e) => e.toJson()).toList();
    return json;
  }

  Data({
    required this.problemTypess,
  });
}

