part of 'generated.dart';

class InsertUserVariablesBuilder {
  String email;
  bool isAdmin;

  final FirebaseDataConnect _dataConnect;
  InsertUserVariablesBuilder(this._dataConnect, {required  this.email,required  this.isAdmin,});
  Deserializer<InsertUserData> dataDeserializer = (dynamic json)  => InsertUserData.fromJson(jsonDecode(json));
  Serializer<InsertUserVariables> varsSerializer = (InsertUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertUserData, InsertUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertUserData, InsertUserVariables> ref() {
    InsertUserVariables vars= InsertUserVariables(email: email,isAdmin: isAdmin,);
    return _dataConnect.mutation("insertUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertUserUserInsert {
  final String userId;
  InsertUserUserInsert.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertUserUserInsert otherTyped = other as InsertUserUserInsert;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  InsertUserUserInsert({
    required this.userId,
  });
}

@immutable
class InsertUserData {
  final InsertUserUserInsert user_insert;
  InsertUserData.fromJson(dynamic json):
  
  user_insert = InsertUserUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertUserData otherTyped = other as InsertUserData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  InsertUserData({
    required this.user_insert,
  });
}

@immutable
class InsertUserVariables {
  final String email;
  final bool isAdmin;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertUserVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertUserVariables otherTyped = other as InsertUserVariables;
    return email == otherTyped.email && 
    isAdmin == otherTyped.isAdmin;
    
  }
  @override
  int get hashCode => Object.hashAll([email.hashCode, isAdmin.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    json['isAdmin'] = nativeToJson<bool>(isAdmin);
    return json;
  }

  InsertUserVariables({
    required this.email,
    required this.isAdmin,
  });
}

