part of 'generated.dart';

class ListProblemTagsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListProblemTagsVariablesBuilder(this._dataConnect, );
  Deserializer<ListProblemTagsData> dataDeserializer = (dynamic json)  => ListProblemTagsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListProblemTagsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListProblemTagsData, void> ref() {
    
    return _dataConnect.query("ListProblemTags", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListProblemTagsProblemTags {
  final String problemTagId;
  final String tagName;
  final String tagThaiName;
  ListProblemTagsProblemTags.fromJson(dynamic json):
  
  problemTagId = nativeFromJson<String>(json['problemTagId']),
  tagName = nativeFromJson<String>(json['tagName']),
  tagThaiName = nativeFromJson<String>(json['tagThaiName']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemTagsProblemTags otherTyped = other as ListProblemTagsProblemTags;
    return problemTagId == otherTyped.problemTagId && 
    tagName == otherTyped.tagName && 
    tagThaiName == otherTyped.tagThaiName;
    
  }
  @override
  int get hashCode => Object.hashAll([problemTagId.hashCode, tagName.hashCode, tagThaiName.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemTagId'] = nativeToJson<String>(problemTagId);
    json['tagName'] = nativeToJson<String>(tagName);
    json['tagThaiName'] = nativeToJson<String>(tagThaiName);
    return json;
  }

  ListProblemTagsProblemTags({
    required this.problemTagId,
    required this.tagName,
    required this.tagThaiName,
  });
}

@immutable
class ListProblemTagsData {
  final List<ListProblemTagsProblemTags> problemTags;
  ListProblemTagsData.fromJson(dynamic json):
  
  problemTags = (json['problemTags'] as List<dynamic>)
        .map((e) => ListProblemTagsProblemTags.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemTagsData otherTyped = other as ListProblemTagsData;
    return problemTags == otherTyped.problemTags;
    
  }
  @override
  int get hashCode => problemTags.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemTags'] = problemTags.map((e) => e.toJson()).toList();
    return json;
  }

  ListProblemTagsData({
    required this.problemTags,
  });
}

