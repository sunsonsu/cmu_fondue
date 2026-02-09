import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  final String id;
  final String email;

  UserEntity({
    required this.id,
    required this.email,
  });

  factory UserEntity.fromFirebase(User user) {
    return UserEntity(
      id: user.uid,
      email: user.email ?? '',
    );
  }
}
