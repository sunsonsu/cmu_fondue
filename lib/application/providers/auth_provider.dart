import 'package:flutter/material.dart';
import 'package:cmu_fondue/domain/entities/user_entity.dart';
import 'package:cmu_fondue/domain/repositories/auth_repo.dart';

class AppAuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  UserEntity? _user;
  bool _isLoading = true;

  AppAuthProvider(this._authRepository) {
    // ติดตามสถานะการ Login ทันที
    _authRepository.authStateChanges().listen((user) {
      _user = user;
      _isLoading = false;
      notifyListeners(); // บอก Widget ที่ฟังอยู่ให้เปลี่ยนหน้า
    });
  }

  UserEntity? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<void> logout() async {
    await _authRepository.logout();
  }
}