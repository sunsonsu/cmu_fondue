/*
 * File: auth_repo_impl.dart
 * Description: Concrete implementation of the AuthRepository.
 * Responsibilities: Bridges the authentication use cases to the actual Firebase and Data Connect data sources.
 * Author: App Team
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/entities/user_entity.dart';
import 'package:cmu_fondue/domain/repositories/auth_repo.dart';
import 'package:cmu_fondue/data/datasources/firebase_auth_data_source.dart';
import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';

/// Implements the authentication domain logic by connecting the raw Firebase data source to the rest of the application.
class AuthRepositoryImpl implements AuthRepository {
  /// The local data source handling direct Firebase Auth operations.
  final FirebaseAuthDataSource dataSource;

  /// The generated connector responsible for direct database mutations via Firebase Data Connect.
  final ConnectorConnector connector;

  /// Initializes a new instance of [AuthRepositoryImpl].
  AuthRepositoryImpl(this.dataSource, this.connector);

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await dataSource.login(email, password);
    return UserEntity.fromFirebase(user);
  }

  @override
  Future<UserEntity> register(String email, String password) async {
    final user = await dataSource.register(email, password);
    await user.getIdToken();

    try {
      await connector.insertUser(email: email, isAdmin: false).execute();
    } catch (e) {
      if (e is DataConnectError) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      }
      rethrow;
    }

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
    final user = dataSource.currentUser;
    return user != null ? UserEntity.fromFirebase(user) : null;
  }
}
