import 'package:cmu_fondue/domain/entities/user_entity.dart';
import 'package:cmu_fondue/domain/repositories/auth_repo.dart';
import 'package:cmu_fondue/data/datasources/firebase_auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await dataSource.login(email, password);
    return UserEntity.fromFirebase(user);
  }

  @override
  Future<UserEntity> register(String email, String password) async {
    final user = await dataSource.register(email, password);
    return UserEntity.fromFirebase(user);
  }

  @override
  Stream<UserEntity?> authStateChanges() {
    return dataSource.authStateChanges().map(
      (user) => user == null ? null : UserEntity.fromFirebase(user),
    );
  }

  @override
  Future<void> logout() {
    return dataSource.logout();
  }

  @override
  UserEntity? get currentUser {
    final user = dataSource.currentUser; // ดึงมาจาก FirebaseDataSource
    return user != null ? UserEntity.fromFirebase(user) : null;
  }
}

