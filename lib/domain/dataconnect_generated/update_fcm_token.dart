part of 'generated.dart';

class UpdateFcmTokenVariablesBuilder {
  String userId;
  String fcmToken;

  final FirebaseDataConnect _dataConnect;
  UpdateFcmTokenVariablesBuilder(this._dataConnect, {required  this.userId,required  this.fcmToken,});
  Deserializer<UpdateFcmTokenData> dataDeserializer = (dynamic json)  => UpdateFcmTokenData.fromJson(jsonDecode(json));
  Serializer<UpdateFcmTokenVariables> varsSerializer = (UpdateFcmTokenVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateFcmTokenData, UpdateFcmTokenVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateFcmTokenData, UpdateFcmTokenVariables> ref() {
    UpdateFcmTokenVariables vars= UpdateFcmTokenVariables(userId: userId,fcmToken: fcmToken,);
    return _dataConnect.mutation("UpdateFcmToken", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateFcmTokenUserUpdate {
  final String userId;
  UpdateFcmTokenUserUpdate.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateFcmTokenUserUpdate otherTyped = other as UpdateFcmTokenUserUpdate;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  UpdateFcmTokenUserUpdate({
    required this.userId,
  });
}

@immutable
class UpdateFcmTokenData {
  final UpdateFcmTokenUserUpdate? user_update;
  UpdateFcmTokenData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : UpdateFcmTokenUserUpdate.fromJson(json['user_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateFcmTokenData otherTyped = other as UpdateFcmTokenData;
    return user_update == otherTyped.user_update;
    
  }
  @override
  int get hashCode => user_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user_update != null) {
      json['user_update'] = user_update!.toJson();
    }
    return json;
  }

  UpdateFcmTokenData({
    this.user_update,
  });
}

@immutable
class UpdateFcmTokenVariables {
  final String userId;
  final String fcmToken;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateFcmTokenVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']),
  fcmToken = nativeFromJson<String>(json['fcmToken']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateFcmTokenVariables otherTyped = other as UpdateFcmTokenVariables;
    return userId == otherTyped.userId && 
    fcmToken == otherTyped.fcmToken;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, fcmToken.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['fcmToken'] = nativeToJson<String>(fcmToken);
    return json;
  }

  UpdateFcmTokenVariables({
    required this.userId,
    required this.fcmToken,
  });
}

