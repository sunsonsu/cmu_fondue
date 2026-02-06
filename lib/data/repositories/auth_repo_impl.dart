import 'package:cmu_fondue/domain/entities/user_entity.dart';
import 'package:cmu_fondue/domain/repositories/auth_repo.dart';
import 'package:cmu_fondue/data/datasources/firebase_auth_data_source.dart';

class AuthRepoImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepoImpl(this.dataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await dataSource.login(email, password);
    return UserEntity(
      id: user.uid,
      email: user.email!,
    );
  }

  @override
  Future<UserEntity> register(String email, String password) async {
    final user = await dataSource.register(email, password);
    return UserEntity(
      id: user.uid,
      email: user.email!,
    );
  }

  @override
  Future<void> logout() async {
    return dataSource.logout();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = dataSource.getCurrentUser();
    if (user == null) return null;

    return UserEntity(
      id: user.uid,
      email: user.email!,
    );
  }
}
