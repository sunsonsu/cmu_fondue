part of 'generated.dart';

class ProblemsByTagFullVariablesBuilder {
  String TagId;

  final FirebaseDataConnect _dataConnect;
  ProblemsByTagFullVariablesBuilder(this._dataConnect, {required  this.TagId,});
  Deserializer<ProblemsByTagFullData> dataDeserializer = (dynamic json)  => ProblemsByTagFullData.fromJson(jsonDecode(json));
  Serializer<ProblemsByTagFullVariables> varsSerializer = (ProblemsByTagFullVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ProblemsByTagFullData, ProblemsByTagFullVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ProblemsByTagFullData, ProblemsByTagFullVariables> ref() {
    ProblemsByTagFullVariables vars= ProblemsByTagFullVariables(TagId: TagId,);
    return _dataConnect.query("ProblemsByTagFull", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ProblemsByTagFullProblems {
  final String problemId;
  final ProblemsByTagFullProblemsReporter reporter;
  final String title;
  final String detail;
  final String locationName;
  final ProblemsByTagFullProblemsProblemType problemType;
  final ProblemsByTagFullProblemsCurrentTags currentTags;
  final Timestamp createdAt;
  final double problemLat;
  final double problemLng;
  final int upvoteCount;
  final List<ProblemsByTagFullProblemsUserUpvotesOnProblem> userUpvotes_on_problem;
  final List<ProblemsByTagFullProblemsProblemImagesOnProblem> problemImages_on_problem;
  ProblemsByTagFullProblems.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']),
  reporter = ProblemsByTagFullProblemsReporter.fromJson(json['reporter']),
  title = nativeFromJson<String>(json['title']),
  detail = nativeFromJson<String>(json['detail']),
  locationName = nativeFromJson<String>(json['locationName']),
  problemType = ProblemsByTagFullProblemsProblemType.fromJson(json['problemType']),
  currentTags = ProblemsByTagFullProblemsCurrentTags.fromJson(json['currentTags']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  problemLat = nativeFromJson<double>(json['problemLat']),
  problemLng = nativeFromJson<double>(json['problemLng']),
  upvoteCount = nativeFromJson<int>(json['upvoteCount']),
  userUpvotes_on_problem = (json['userUpvotes_on_problem'] as List<dynamic>)
        .map((e) => ProblemsByTagFullProblemsUserUpvotesOnProblem.fromJson(e))
        .toList(),
  problemImages_on_problem = (json['problemImages_on_problem'] as List<dynamic>)
        .map((e) => ProblemsByTagFullProblemsProblemImagesOnProblem.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagFullProblems otherTyped = other as ProblemsByTagFullProblems;
    return problemId == otherTyped.problemId && 
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
  int get hashCode => Object.hashAll([problemId.hashCode, reporter.hashCode, title.hashCode, detail.hashCode, locationName.hashCode, problemType.hashCode, currentTags.hashCode, createdAt.hashCode, problemLat.hashCode, problemLng.hashCode, upvoteCount.hashCode, userUpvotes_on_problem.hashCode, problemImages_on_problem.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problemId'] = nativeToJson<String>(problemId);
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

  ProblemsByTagFullProblems({
    required this.problemId,
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
class ProblemsByTagFullProblemsReporter {
  final String userId;
  final String email;
  final bool isAdmin;
  ProblemsByTagFullProblemsReporter.fromJson(dynamic json):
  
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

    final ProblemsByTagFullProblemsReporter otherTyped = other as ProblemsByTagFullProblemsReporter;
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

  ProblemsByTagFullProblemsReporter({
    required this.userId,
    required this.email,
    required this.isAdmin,
  });
}

@immutable
class ProblemsByTagFullProblemsProblemType {
  final String typeName;
  final String typeThaiName;
  ProblemsByTagFullProblemsProblemType.fromJson(dynamic json):
  
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

    final ProblemsByTagFullProblemsProblemType otherTyped = other as ProblemsByTagFullProblemsProblemType;
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

  ProblemsByTagFullProblemsProblemType({
    required this.typeName,
    required this.typeThaiName,
  });
}

@immutable
class ProblemsByTagFullProblemsCurrentTags {
  final String tagName;
  final String tagThaiName;
  ProblemsByTagFullProblemsCurrentTags.fromJson(dynamic json):
  
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

    final ProblemsByTagFullProblemsCurrentTags otherTyped = other as ProblemsByTagFullProblemsCurrentTags;
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

  ProblemsByTagFullProblemsCurrentTags({
    required this.tagName,
    required this.tagThaiName,
  });
}

@immutable
class ProblemsByTagFullProblemsUserUpvotesOnProblem {
  final String userId;
  ProblemsByTagFullProblemsUserUpvotesOnProblem.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagFullProblemsUserUpvotesOnProblem otherTyped = other as ProblemsByTagFullProblemsUserUpvotesOnProblem;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  ProblemsByTagFullProblemsUserUpvotesOnProblem({
    required this.userId,
  });
}

@immutable
class ProblemsByTagFullProblemsProblemImagesOnProblem {
  final String imageUrl;
  final String fileName;
  final String imageType;
  ProblemsByTagFullProblemsProblemImagesOnProblem.fromJson(dynamic json):
  
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

    final ProblemsByTagFullProblemsProblemImagesOnProblem otherTyped = other as ProblemsByTagFullProblemsProblemImagesOnProblem;
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

  ProblemsByTagFullProblemsProblemImagesOnProblem({
    required this.imageUrl,
    required this.fileName,
    required this.imageType,
  });
}

@immutable
class ProblemsByTagFullData {
  final List<ProblemsByTagFullProblems> problems;
  ProblemsByTagFullData.fromJson(dynamic json):
  
  problems = (json['problems'] as List<dynamic>)
        .map((e) => ProblemsByTagFullProblems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagFullData otherTyped = other as ProblemsByTagFullData;
    return problems == otherTyped.problems;
    
  }
  @override
  int get hashCode => problems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problems'] = problems.map((e) => e.toJson()).toList();
    return json;
  }

  ProblemsByTagFullData({
    required this.problems,
  });
}

@immutable
class ProblemsByTagFullVariables {
  final String TagId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ProblemsByTagFullVariables.fromJson(Map<String, dynamic> json):
  
  TagId = nativeFromJson<String>(json['TagId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagFullVariables otherTyped = other as ProblemsByTagFullVariables;
    return TagId == otherTyped.TagId;
    
  }
  @override
  int get hashCode => TagId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['TagId'] = nativeToJson<String>(TagId);
    return json;
  }

  ProblemsByTagFullVariables({
    required this.TagId,
  });
}

