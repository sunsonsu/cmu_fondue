part of 'generated.dart';

class ProblemsByTypeFullVariablesBuilder {
  String TypeId;

  final FirebaseDataConnect _dataConnect;
  ProblemsByTypeFullVariablesBuilder(this._dataConnect, {required  this.TypeId,});
  Deserializer<ProblemsByTypeFullData> dataDeserializer = (dynamic json)  => ProblemsByTypeFullData.fromJson(jsonDecode(json));
  Serializer<ProblemsByTypeFullVariables> varsSerializer = (ProblemsByTypeFullVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ProblemsByTypeFullData, ProblemsByTypeFullVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ProblemsByTypeFullData, ProblemsByTypeFullVariables> ref() {
    ProblemsByTypeFullVariables vars= ProblemsByTypeFullVariables(TypeId: TypeId,);
    return _dataConnect.query("ProblemsByTypeFull", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ProblemsByTypeFullProblems {
  final String problemId;
  final String reporterId;
  final ProblemsByTypeFullProblemsReporter reporter;
  final String title;
  final String detail;
  final String locationName;
  final ProblemsByTypeFullProblemsProblemType problemType;
  final ProblemsByTypeFullProblemsCurrentTags currentTags;
  final Timestamp createdAt;
  final double problemLat;
  final double problemLng;
  final int upvoteCount;
  final List<ProblemsByTypeFullProblemsUserUpvotesOnProblem> userUpvotes_on_problem;
  final List<ProblemsByTypeFullProblemsProblemImagesOnProblem> problemImages_on_problem;
  ProblemsByTypeFullProblems.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']),
  reporterId = nativeFromJson<String>(json['reporterId']),
  reporter = ProblemsByTypeFullProblemsReporter.fromJson(json['reporter']),
  title = nativeFromJson<String>(json['title']),
  detail = nativeFromJson<String>(json['detail']),
  locationName = nativeFromJson<String>(json['locationName']),
  problemType = ProblemsByTypeFullProblemsProblemType.fromJson(json['problemType']),
  currentTags = ProblemsByTypeFullProblemsCurrentTags.fromJson(json['currentTags']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  problemLat = nativeFromJson<double>(json['problemLat']),
  problemLng = nativeFromJson<double>(json['problemLng']),
  upvoteCount = nativeFromJson<int>(json['upvoteCount']),
  userUpvotes_on_problem = (json['userUpvotes_on_problem'] as List<dynamic>)
        .map((e) => ProblemsByTypeFullProblemsUserUpvotesOnProblem.fromJson(e))
        .toList(),
  problemImages_on_problem = (json['problemImages_on_problem'] as List<dynamic>)
        .map((e) => ProblemsByTypeFullProblemsProblemImagesOnProblem.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTypeFullProblems otherTyped = other as ProblemsByTypeFullProblems;
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

  ProblemsByTypeFullProblems({
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
class ProblemsByTypeFullProblemsReporter {
  final String userId;
  final String email;
  final bool isAdmin;
  ProblemsByTypeFullProblemsReporter.fromJson(dynamic json):
  
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

    final ProblemsByTypeFullProblemsReporter otherTyped = other as ProblemsByTypeFullProblemsReporter;
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

  ProblemsByTypeFullProblemsReporter({
    required this.userId,
    required this.email,
    required this.isAdmin,
  });
}

@immutable
class ProblemsByTypeFullProblemsProblemType {
  final String typeName;
  final String typeThaiName;
  ProblemsByTypeFullProblemsProblemType.fromJson(dynamic json):
  
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

    final ProblemsByTypeFullProblemsProblemType otherTyped = other as ProblemsByTypeFullProblemsProblemType;
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

  ProblemsByTypeFullProblemsProblemType({
    required this.typeName,
    required this.typeThaiName,
  });
}

@immutable
class ProblemsByTypeFullProblemsCurrentTags {
  final String tagName;
  final String tagThaiName;
  ProblemsByTypeFullProblemsCurrentTags.fromJson(dynamic json):
  
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

    final ProblemsByTypeFullProblemsCurrentTags otherTyped = other as ProblemsByTypeFullProblemsCurrentTags;
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

  ProblemsByTypeFullProblemsCurrentTags({
    required this.tagName,
    required this.tagThaiName,
  });
}

@immutable
class ProblemsByTypeFullProblemsUserUpvotesOnProblem {
  final String userId;
  ProblemsByTypeFullProblemsUserUpvotesOnProblem.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTypeFullProblemsUserUpvotesOnProblem otherTyped = other as ProblemsByTypeFullProblemsUserUpvotesOnProblem;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  ProblemsByTypeFullProblemsUserUpvotesOnProblem({
    required this.userId,
  });
}

@immutable
class ProblemsByTypeFullProblemsProblemImagesOnProblem {
  final String imageUrl;
  final String fileName;
  final String imageType;
  ProblemsByTypeFullProblemsProblemImagesOnProblem.fromJson(dynamic json):
  
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

    final ProblemsByTypeFullProblemsProblemImagesOnProblem otherTyped = other as ProblemsByTypeFullProblemsProblemImagesOnProblem;
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

  ProblemsByTypeFullProblemsProblemImagesOnProblem({
    required this.imageUrl,
    required this.fileName,
    required this.imageType,
  });
}

@immutable
class ProblemsByTypeFullData {
  final List<ProblemsByTypeFullProblems> problems;
  ProblemsByTypeFullData.fromJson(dynamic json):
  
  problems = (json['problems'] as List<dynamic>)
        .map((e) => ProblemsByTypeFullProblems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTypeFullData otherTyped = other as ProblemsByTypeFullData;
    return problems == otherTyped.problems;
    
  }
  @override
  int get hashCode => problems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problems'] = problems.map((e) => e.toJson()).toList();
    return json;
  }

  ProblemsByTypeFullData({
    required this.problems,
  });
}

@immutable
class ProblemsByTypeFullVariables {
  final String TypeId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ProblemsByTypeFullVariables.fromJson(Map<String, dynamic> json):
  
  TypeId = nativeFromJson<String>(json['TypeId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTypeFullVariables otherTyped = other as ProblemsByTypeFullVariables;
    return TypeId == otherTyped.TypeId;
    
  }
  @override
  int get hashCode => TypeId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['TypeId'] = nativeToJson<String>(TypeId);
    return json;
  }

  ProblemsByTypeFullVariables({
    required this.TypeId,
  });
}

