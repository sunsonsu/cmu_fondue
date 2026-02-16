import 'package:cmu_fondue/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String email, String password);
  Stream<UserEntity?> authStateChanges();
  UserEntity? get currentUser;
  Future<void> logout();
}
