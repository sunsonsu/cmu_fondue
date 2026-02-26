import 'package:cmu_fondue/domain/entities/user_entity.dart';

abstract class UserRepo {
  Future<void> updateFcmToken(String userId, String token);
  Future<UserEntity?> getUserById(String userId);
}