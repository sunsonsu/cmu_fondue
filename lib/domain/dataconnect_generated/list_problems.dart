part of 'generated.dart';

class ListProblemsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListProblemsVariablesBuilder(this._dataConnect, );
  Deserializer<ListProblemsData> dataDeserializer = (dynamic json)  => ListProblemsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListProblemsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListProblemsData, void> ref() {
    
    return _dataConnect.query("ListProblems", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListProblemsProblems {
  final String problemId;
  final ListProblemsProblemsReporter reporter;
  final String title;
  final String detail;
  final String locationName;
  final ListProblemsProblemsProblemType problemType;
  final ListProblemsProblemsCurrentTags currentTags;
  final Timestamp createdAt;
  final double problemLat;
  final double problemLng;
  final int upvoteCount;
  final List<ListProblemsProblemsUserUpvotesOnProblem> userUpvotes_on_problem;
  final List<ListProblemsProblemsProblemImagesOnProblem> problemImages_on_problem;
  ListProblemsProblems.fromJson(dynamic json):
  
  problemId = nativeFromJson<String>(json['problemId']),
  reporter = ListProblemsProblemsReporter.fromJson(json['reporter']),
  title = nativeFromJson<String>(json['title']),
  detail = nativeFromJson<String>(json['detail']),
  locationName = nativeFromJson<String>(json['locationName']),
  problemType = ListProblemsProblemsProblemType.fromJson(json['problemType']),
  currentTags = ListProblemsProblemsCurrentTags.fromJson(json['currentTags']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  problemLat = nativeFromJson<double>(json['problemLat']),
  problemLng = nativeFromJson<double>(json['problemLng']),
  upvoteCount = nativeFromJson<int>(json['upvoteCount']),
  userUpvotes_on_problem = (json['userUpvotes_on_problem'] as List<dynamic>)
        .map((e) => ListProblemsProblemsUserUpvotesOnProblem.fromJson(e))
        .toList(),
  problemImages_on_problem = (json['problemImages_on_problem'] as List<dynamic>)
        .map((e) => ListProblemsProblemsProblemImagesOnProblem.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemsProblems otherTyped = other as ListProblemsProblems;
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

  ListProblemsProblems({
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
class ListProblemsProblemsReporter {
  final String userId;
  final String email;
  final bool isAdmin;
  ListProblemsProblemsReporter.fromJson(dynamic json):
  
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

    final ListProblemsProblemsReporter otherTyped = other as ListProblemsProblemsReporter;
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

  ListProblemsProblemsReporter({
    required this.userId,
    required this.email,
    required this.isAdmin,
  });
}

@immutable
class ListProblemsProblemsProblemType {
  final String typeName;
  final String typeThaiName;
  ListProblemsProblemsProblemType.fromJson(dynamic json):
  
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

    final ListProblemsProblemsProblemType otherTyped = other as ListProblemsProblemsProblemType;
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

  ListProblemsProblemsProblemType({
    required this.typeName,
    required this.typeThaiName,
  });
}

@immutable
class ListProblemsProblemsCurrentTags {
  final String tagName;
  final String tagThaiName;
  ListProblemsProblemsCurrentTags.fromJson(dynamic json):
  
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

    final ListProblemsProblemsCurrentTags otherTyped = other as ListProblemsProblemsCurrentTags;
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

  ListProblemsProblemsCurrentTags({
    required this.tagName,
    required this.tagThaiName,
  });
}

@immutable
class ListProblemsProblemsUserUpvotesOnProblem {
  final String userId;
  ListProblemsProblemsUserUpvotesOnProblem.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemsProblemsUserUpvotesOnProblem otherTyped = other as ListProblemsProblemsUserUpvotesOnProblem;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  ListProblemsProblemsUserUpvotesOnProblem({
    required this.userId,
  });
}

@immutable
class ListProblemsProblemsProblemImagesOnProblem {
  final String imageUrl;
  final String fileName;
  final String imageType;
  ListProblemsProblemsProblemImagesOnProblem.fromJson(dynamic json):
  
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

    final ListProblemsProblemsProblemImagesOnProblem otherTyped = other as ListProblemsProblemsProblemImagesOnProblem;
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

  ListProblemsProblemsProblemImagesOnProblem({
    required this.imageUrl,
    required this.fileName,
    required this.imageType,
  });
}

@immutable
class ListProblemsData {
  final List<ListProblemsProblems> problems;
  ListProblemsData.fromJson(dynamic json):
  
  problems = (json['problems'] as List<dynamic>)
        .map((e) => ListProblemsProblems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProblemsData otherTyped = other as ListProblemsData;
    return problems == otherTyped.problems;
    
  }
  @override
  int get hashCode => problems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['problems'] = problems.map((e) => e.toJson()).toList();
    return json;
  }

  ListProblemsData({
    required this.problems,
  });
}

