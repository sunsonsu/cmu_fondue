part of 'generated.dart';

class GetUserByIdVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetUserByIdVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetUserByIdData> dataDeserializer = (dynamic json)  => GetUserByIdData.fromJson(jsonDecode(json));
  Serializer<GetUserByIdVariables> varsSerializer = (GetUserByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserByIdData, GetUserByIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserByIdData, GetUserByIdVariables> ref() {
    GetUserByIdVariables vars= GetUserByIdVariables(userId: userId,);
    return _dataConnect.query("GetUserById", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserByIdUser {
  final String userId;
  final String email;
  final bool isAdmin;
  final String? fcmToken;
  GetUserByIdUser.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']),
  email = nativeFromJson<String>(json['email']),
  isAdmin = nativeFromJson<bool>(json['isAdmin']),
  fcmToken = json['fcmToken'] == null ? null : nativeFromJson<String>(json['fcmToken']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByIdUser otherTyped = other as GetUserByIdUser;
    return userId == otherTyped.userId && 
    email == otherTyped.email && 
    isAdmin == otherTyped.isAdmin && 
    fcmToken == otherTyped.fcmToken;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, email.hashCode, isAdmin.hashCode, fcmToken.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['email'] = nativeToJson<String>(email);
    json['isAdmin'] = nativeToJson<bool>(isAdmin);
    if (fcmToken != null) {
      json['fcmToken'] = nativeToJson<String?>(fcmToken);
    }
    return json;
  }

  GetUserByIdUser({
    required this.userId,
    required this.email,
    required this.isAdmin,
    this.fcmToken,
  });
}

@immutable
class GetUserByIdData {
  final GetUserByIdUser? user;
  GetUserByIdData.fromJson(dynamic json):
  
  user = json['user'] == null ? null : GetUserByIdUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByIdData otherTyped = other as GetUserByIdData;
    return user == otherTyped.user;
    
  }
  @override
  int get hashCode => user.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  GetUserByIdData({
    this.user,
  });
}

@immutable
class GetUserByIdVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserByIdVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByIdVariables otherTyped = other as GetUserByIdVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetUserByIdVariables({
    required this.userId,
  });
}

