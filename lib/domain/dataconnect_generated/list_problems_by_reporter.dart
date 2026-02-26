part of 'generated.dart';

class ListProblemsByReporterVariablesBuilder {
  String reporterId;

  final FirebaseDataConnect _dataConnect;
  ListProblemsByReporterVariablesBuilder(this._dataConnect, {required  this.reporterId,});
  Deserializer<ListProblemsByReporterData> dataDeserializer = (dynamic json)  => ListProblemsByReporterData.fromJson(jsonDecode(json));
  Serializer<ListProblemsByReporterVariables> varsSerializer = (ListProblemsByReporterVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListProblemsByReporterData, ListProblemsByReporterVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListProblemsByReporterData, ListProblemsByReporterVariables> ref() {
    ListProblemsByReporterVariables vars= ListProblemsByReporterVariables(reporterId: reporterId,);
    return _dataConnect.query("ListProblemsByReporter", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListProblemsByReporterProblems {
  final String problemId;
  final String reporterId;
  final ListProblemsByReporterProblemsReporter reporter;
  final String title;
  final String detail;
  final String locationName;
  final ListProblemsByReporterProblemsProblemType problemType;
  final ListProblemsByReporterProblemsCurrentTags currentTags;
  final Timestamp createdAt;
  final double problemLat;
  final double problemLng;
  final int upvoteCount;
  final List<ListProblemsByReporterProblemsUserUpvotesOnProblem> userUpvotes_on_problem;
  final List<ListProblemsByReporterProblemsProblemImagesOnProblem> problemImages_on_problem;
  ListProblemsByReporterProblems.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']),
  reporterId = nativeFromJson<String>(json['reporterId']),
  reporter = ListProblemsByReporterProblemsReporter.fromJson(json['reporter']),
  title = nativeFromJson<String>(json['title']),
  detail = nativeFromJson<String>(json['detail']),
  locationName = nativeFromJson<String>(json['locationName']),
  problemType = ListProblemsByReporterProblemsProblemType.fromJson(json['problemType']),
  currentTags = ListProblemsByReporterProblemsCurrentTags.fromJson(json['currentTags']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  problemLat = nativeFromJson<double>(json['problemLat']),
  problemLng = nativeFromJson<double>(json['problemLng']),
  upvoteCount = nativeFromJson<int>(json['upvoteCount']),
  userUpvotes_on_problem = (json['userUpvotes_on_problem'] as List<dynamic>)
        .map((e) => ListProblemsByReporterProblemsUserUpvotesOnProblem.fromJson(e))
        .toList(),
  problemImages_on_problem = (json['problemImages_on_problem'] as List<dynamic>)
        .map((e) => ListProblemsByReporterProblemsProblemImagesOnProblem.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemsByReporterProblems otherTyped = other as ListProblemsByReporterProblems;
    return problemId == otherTyped.problemId && 
    reporterId == otherTyped.reporterId && 
    reporter == otherTyped.reporter && 
    title == otherTyped.title && 
    detail == otherTyped.detail && 
    locationName == otherTyped.locationName && 
    problemType == otherTyped.problemType && 
    currentTags == otherTyped.currentTags && 
    createdAt == otherTyped.createdAt && 
    problemLat == otherTyped.problemLat && 
    problemLng == otherTyped.problemLng && 
    upvoteCount == otherTyped.upvoteCount && 
    userUpvotes_on_problem == otherTyped.userUpvotes_on_problem && 
    problemImages_on_problem == otherTyped.problemImages_on_problem;
    
  }
  @override
  int get hashCode => Object.hashAll([problemId.hashCode, reporterId.hashCode, reporter.hashCode, title.hashCode, detail.hashCode, locationName.hashCode, problemType.hashCode, currentTags.hashCode, createdAt.hashCode, problemLat.hashCode, problemLng.hashCode, upvoteCount.hashCode, userUpvotes_on_problem.hashCode, problemImages_on_problem.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
    json['reporterId'] = nativeToJson<String>(reporterId);
    json['reporter'] = reporter.toJson();
    json['title'] = nativeToJson<String>(title);
    json['detail'] = nativeToJson<String>(detail);
    json['locationName'] = nativeToJson<String>(locationName);
    json['problemType'] = problemType.toJson();
    json['currentTags'] = currentTags.toJson();
    json['createdAt'] = createdAt.toJson();
    json['problemLat'] = nativeToJson<double>(problemLat);
    json['problemLng'] = nativeToJson<double>(problemLng);
    json['upvoteCount'] = nativeToJson<int>(upvoteCount);
    json['userUpvotes_on_problem'] = userUpvotes_on_problem.map((e) => e.toJson()).toList();
    json['problemImages_on_problem'] = problemImages_on_problem.map((e) => e.toJson()).toList();
    return json;
  }

  ListProblemsByReporterProblems({
    required this.problemId,
    required this.reporterId,
    required this.reporter,
    required this.title,
    required this.detail,
    required this.locationName,
    required this.problemType,
    required this.currentTags,
    required this.createdAt,
    required this.problemLat,
    required this.problemLng,
    required this.upvoteCount,
    required this.userUpvotes_on_problem,
    required this.problemImages_on_problem,
  });
}

@immutable
class ListProblemsByReporterProblemsReporter {
  final String userId;
  final String email;
  final bool isAdmin;
  ListProblemsByReporterProblemsReporter.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']),
  email = nativeFromJson<String>(json['email']),
  isAdmin = nativeFromJson<bool>(json['isAdmin']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemsByReporterProblemsReporter otherTyped = other as ListProblemsByReporterProblemsReporter;
    return userId == otherTyped.userId && 
    email == otherTyped.email && 
    isAdmin == otherTyped.isAdmin;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, email.hashCode, isAdmin.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['email'] = nativeToJson<String>(email);
    json['isAdmin'] = nativeToJson<bool>(isAdmin);
    return json;
  }

  ListProblemsByReporterProblemsReporter({
    required this.userId,
    required this.email,
    required this.isAdmin,
  });
}

@immutable
class ListProblemsByReporterProblemsProblemType {
  final String typeName;
  final String typeThaiName;
  ListProblemsByReporterProblemsProblemType.fromJson(dynamic json):
  
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

    final ListProblemsByReporterProblemsProblemType otherTyped = other as ListProblemsByReporterProblemsProblemType;
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

  ListProblemsByReporterProblemsProblemType({
    required this.typeName,
    required this.typeThaiName,
  });
}

@immutable
class ListProblemsByReporterProblemsCurrentTags {
  final String tagName;
  final String tagThaiName;
  ListProblemsByReporterProblemsCurrentTags.fromJson(dynamic json):
  
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

    final ListProblemsByReporterProblemsCurrentTags otherTyped = other as ListProblemsByReporterProblemsCurrentTags;
    return tagName == otherTyped.tagName && 
    tagThaiName == otherTyped.tagThaiName;
    
  }
  @override
  int get hashCode => Object.hashAll([tagName.hashCode, tagThaiName.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tagName'] = nativeToJson<String>(tagName);
    json['tagThaiName'] = nativeToJson<String>(tagThaiName);
    return json;
  }

  ListProblemsByReporterProblemsCurrentTags({
    required this.tagName,
    required this.tagThaiName,
  });
}

@immutable
class ListProblemsByReporterProblemsUserUpvotesOnProblem {
  final String userId;
  ListProblemsByReporterProblemsUserUpvotesOnProblem.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemsByReporterProblemsUserUpvotesOnProblem otherTyped = other as ListProblemsByReporterProblemsUserUpvotesOnProblem;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  ListProblemsByReporterProblemsUserUpvotesOnProblem({
    required this.userId,
  });
}

@immutable
class ListProblemsByReporterProblemsProblemImagesOnProblem {
  final String imageUrl;
  final String fileName;
  final String imageType;
  ListProblemsByReporterProblemsProblemImagesOnProblem.fromJson(dynamic json):
  
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  fileName = nativeFromJson<String>(json['fileName']),
  imageType = nativeFromJson<String>(json['imageType']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemsByReporterProblemsProblemImagesOnProblem otherTyped = other as ListProblemsByReporterProblemsProblemImagesOnProblem;
    return imageUrl == otherTyped.imageUrl && 
    fileName == otherTyped.fileName && 
    imageType == otherTyped.imageType;
    
  }
  @override
  int get hashCode => Object.hashAll([imageUrl.hashCode, fileName.hashCode, imageType.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    json['fileName'] = nativeToJson<String>(fileName);
    json['imageType'] = nativeToJson<String>(imageType);
    return json;
  }

  ListProblemsByReporterProblemsProblemImagesOnProblem({
    required this.imageUrl,
    required this.fileName,
    required this.imageType,
  });
}

@immutable
class ListProblemsByReporterData {
  final List<ListProblemsByReporterProblems> problems;
  ListProblemsByReporterData.fromJson(dynamic json):
  
  problems = (json['problems'] as List<dynamic>)
        .map((e) => ListProblemsByReporterProblems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemsByReporterData otherTyped = other as ListProblemsByReporterData;
    return problems == otherTyped.problems;
    
  }
  @override
  int get hashCode => problems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problems'] = problems.map((e) => e.toJson()).toList();
    return json;
  }

  ListProblemsByReporterData({
    required this.problems,
  });
}

@immutable
class ListProblemsByReporterVariables {
  final String reporterId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListProblemsByReporterVariables.fromJson(Map<String, dynamic> json):
  
  reporterId = nativeFromJson<String>(json['reporterId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemsByReporterVariables otherTyped = other as ListProblemsByReporterVariables;
    return reporterId == otherTyped.reporterId;
    
  }
  @override
  int get hashCode => reporterId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['reporterId'] = nativeToJson<String>(reporterId);
    return json;
  }

  ListProblemsByReporterVariables({
    required this.reporterId,
  });
}

