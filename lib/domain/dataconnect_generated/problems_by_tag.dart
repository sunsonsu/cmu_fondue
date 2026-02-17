part of 'generated.dart';

class ProblemsByTagVariablesBuilder {
  String TagId;

  final FirebaseDataConnect _dataConnect;
  ProblemsByTagVariablesBuilder(this._dataConnect, {required  this.TagId,});
  Deserializer<ProblemsByTagData> dataDeserializer = (dynamic json)  => ProblemsByTagData.fromJson(jsonDecode(json));
  Serializer<ProblemsByTagVariables> varsSerializer = (ProblemsByTagVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ProblemsByTagData, ProblemsByTagVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ProblemsByTagData, ProblemsByTagVariables> ref() {
    ProblemsByTagVariables vars= ProblemsByTagVariables(TagId: TagId,);
    return _dataConnect.query("ProblemsByTag", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ProblemsByTagProblems {
  final String problemId;
  ProblemsByTagProblems.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagProblems otherTyped = other as ProblemsByTagProblems;
    return problemId == otherTyped.problemId;
    
  }
  @override
  int get hashCode => problemId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    return json;
  }

  ProblemsByTagProblems({
    required this.problemId,
  });
}

@immutable
class ProblemsByTagData {
  final List<ProblemsByTagProblems> problems;
  ProblemsByTagData.fromJson(dynamic json):
  
  problems = (json['problems'] as List<dynamic>)
        .map((e) => ProblemsByTagProblems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagData otherTyped = other as ProblemsByTagData;
    return problems == otherTyped.problems;
    
  }
  @override
  int get hashCode => problems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problems'] = problems.map((e) => e.toJson()).toList();
    return json;
  }

  ProblemsByTagData({
    required this.problems,
  });
}

@immutable
class ProblemsByTagVariables {
  final String TagId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ProblemsByTagVariables.fromJson(Map<String, dynamic> json):
  
  TagId = nativeFromJson<String>(json['TagId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagVariables otherTyped = other as ProblemsByTagVariables;
    return TagId == otherTyped.TagId;
    
  }
  @override
  int get hashCode => TagId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['TagId'] = nativeToJson<String>(TagId);
    return json;
  }

  ProblemsByTagVariables({
    required this.TagId,
  });
}

