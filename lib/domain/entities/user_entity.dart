import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserEntity {
  final String id;
  final String email;
  final bool isAdmin;

  UserEntity({
    required this.id,
    required this.email,
    required this.isAdmin,
  });

  factory UserEntity.fromFirebase(User user) {
    return UserEntity(
      id: user.uid,
      email: user.email ?? '',
      isAdmin: user.uid == dotenv.env['UID_ADMIN'],
    );
  }
}
