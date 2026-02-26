part of 'generated.dart';

class ProblemsByTagAndTypeVariablesBuilder {
  String TagId;
  String TypeId;

  final FirebaseDataConnect _dataConnect;
  ProblemsByTagAndTypeVariablesBuilder(this._dataConnect, {required  this.TagId,required  this.TypeId,});
  Deserializer<ProblemsByTagAndTypeData> dataDeserializer = (dynamic json)  => ProblemsByTagAndTypeData.fromJson(jsonDecode(json));
  Serializer<ProblemsByTagAndTypeVariables> varsSerializer = (ProblemsByTagAndTypeVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ProblemsByTagAndTypeData, ProblemsByTagAndTypeVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ProblemsByTagAndTypeData, ProblemsByTagAndTypeVariables> ref() {
    ProblemsByTagAndTypeVariables vars= ProblemsByTagAndTypeVariables(TagId: TagId,TypeId: TypeId,);
    return _dataConnect.query("ProblemsByTagAndType", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ProblemsByTagAndTypeProblems {
  final String problemId;
  final String reporterId;
  final ProblemsByTagAndTypeProblemsReporter reporter;
  final String title;
  final String detail;
  final String locationName;
  final ProblemsByTagAndTypeProblemsProblemType problemType;
  final ProblemsByTagAndTypeProblemsCurrentTags currentTags;
  final Timestamp createdAt;
  final double problemLat;
  final double problemLng;
  final int upvoteCount;
  final List<ProblemsByTagAndTypeProblemsUserUpvotesOnProblem> userUpvotes_on_problem;
  final List<ProblemsByTagAndTypeProblemsProblemImagesOnProblem> problemImages_on_problem;
  ProblemsByTagAndTypeProblems.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']),
  reporterId = nativeFromJson<String>(json['reporterId']),
  reporter = ProblemsByTagAndTypeProblemsReporter.fromJson(json['reporter']),
  title = nativeFromJson<String>(json['title']),
  detail = nativeFromJson<String>(json['detail']),
  locationName = nativeFromJson<String>(json['locationName']),
  problemType = ProblemsByTagAndTypeProblemsProblemType.fromJson(json['problemType']),
  currentTags = ProblemsByTagAndTypeProblemsCurrentTags.fromJson(json['currentTags']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  problemLat = nativeFromJson<double>(json['problemLat']),
  problemLng = nativeFromJson<double>(json['problemLng']),
  upvoteCount = nativeFromJson<int>(json['upvoteCount']),
  userUpvotes_on_problem = (json['userUpvotes_on_problem'] as List<dynamic>)
        .map((e) => ProblemsByTagAndTypeProblemsUserUpvotesOnProblem.fromJson(e))
        .toList(),
  problemImages_on_problem = (json['problemImages_on_problem'] as List<dynamic>)
        .map((e) => ProblemsByTagAndTypeProblemsProblemImagesOnProblem.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagAndTypeProblems otherTyped = other as ProblemsByTagAndTypeProblems;
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

  ProblemsByTagAndTypeProblems({
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
class ProblemsByTagAndTypeProblemsReporter {
  final String userId;
  final String email;
  final bool isAdmin;
  ProblemsByTagAndTypeProblemsReporter.fromJson(dynamic json):
  
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

    final ProblemsByTagAndTypeProblemsReporter otherTyped = other as ProblemsByTagAndTypeProblemsReporter;
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

  ProblemsByTagAndTypeProblemsReporter({
    required this.userId,
    required this.email,
    required this.isAdmin,
  });
}

@immutable
class ProblemsByTagAndTypeProblemsProblemType {
  final String typeName;
  final String typeThaiName;
  ProblemsByTagAndTypeProblemsProblemType.fromJson(dynamic json):
  
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

    final ProblemsByTagAndTypeProblemsProblemType otherTyped = other as ProblemsByTagAndTypeProblemsProblemType;
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

  ProblemsByTagAndTypeProblemsProblemType({
    required this.typeName,
    required this.typeThaiName,
  });
}

@immutable
class ProblemsByTagAndTypeProblemsCurrentTags {
  final String tagName;
  final String tagThaiName;
  ProblemsByTagAndTypeProblemsCurrentTags.fromJson(dynamic json):
  
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

    final ProblemsByTagAndTypeProblemsCurrentTags otherTyped = other as ProblemsByTagAndTypeProblemsCurrentTags;
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

  ProblemsByTagAndTypeProblemsCurrentTags({
    required this.tagName,
    required this.tagThaiName,
  });
}

@immutable
class ProblemsByTagAndTypeProblemsUserUpvotesOnProblem {
  final String userId;
  ProblemsByTagAndTypeProblemsUserUpvotesOnProblem.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagAndTypeProblemsUserUpvotesOnProblem otherTyped = other as ProblemsByTagAndTypeProblemsUserUpvotesOnProblem;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  ProblemsByTagAndTypeProblemsUserUpvotesOnProblem({
    required this.userId,
  });
}

@immutable
class ProblemsByTagAndTypeProblemsProblemImagesOnProblem {
  final String imageUrl;
  final String fileName;
  final String imageType;
  ProblemsByTagAndTypeProblemsProblemImagesOnProblem.fromJson(dynamic json):
  
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

    final ProblemsByTagAndTypeProblemsProblemImagesOnProblem otherTyped = other as ProblemsByTagAndTypeProblemsProblemImagesOnProblem;
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

  ProblemsByTagAndTypeProblemsProblemImagesOnProblem({
    required this.imageUrl,
    required this.fileName,
    required this.imageType,
  });
}

@immutable
class ProblemsByTagAndTypeData {
  final List<ProblemsByTagAndTypeProblems> problems;
  ProblemsByTagAndTypeData.fromJson(dynamic json):
  
  problems = (json['problems'] as List<dynamic>)
        .map((e) => ProblemsByTagAndTypeProblems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagAndTypeData otherTyped = other as ProblemsByTagAndTypeData;
    return problems == otherTyped.problems;
    
  }
  @override
  int get hashCode => problems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problems'] = problems.map((e) => e.toJson()).toList();
    return json;
  }

  ProblemsByTagAndTypeData({
    required this.problems,
  });
}

@immutable
class ProblemsByTagAndTypeVariables {
  final String TagId;
  final String TypeId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ProblemsByTagAndTypeVariables.fromJson(Map<String, dynamic> json):
  
  TagId = nativeFromJson<String>(json['TagId']),
  TypeId = nativeFromJson<String>(json['TypeId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ProblemsByTagAndTypeVariables otherTyped = other as ProblemsByTagAndTypeVariables;
    return TagId == otherTyped.TagId && 
    TypeId == otherTyped.TypeId;
    
  }
  @override
  int get hashCode => Object.hashAll([TagId.hashCode, TypeId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['TagId'] = nativeToJson<String>(TagId);
    json['TypeId'] = nativeToJson<String>(TypeId);
    return json;
  }

  ProblemsByTagAndTypeVariables({
    required this.TagId,
    required this.TypeId,
  });
}

