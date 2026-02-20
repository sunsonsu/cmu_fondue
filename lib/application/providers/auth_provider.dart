import 'package:cmu_fondue/domain/usecases/setup_notifications_usecase.dart';
import 'package:cmu_fondue/data/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/domain/entities/user_entity.dart';
import 'package:cmu_fondue/domain/repositories/auth_repo.dart';

class AppAuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  final SetupNotificationsUseCase _setupNotificationsUseCase;
  final NotificationService _notificationService = NotificationService();
  UserEntity? _user;
  bool _isLoading = true;

  bool get isAdmin => _user?.isAdmin ?? false;

  AppAuthProvider(this._authRepository, this._setupNotificationsUseCase) {
    // ติดตามสถานะการ Login ทันที
    _authRepository.authStateChanges().listen((user) {
      _user = user;
      _isLoading = false;
      
      if (user != null) {
      _setupFCMToken(user.id);
    }

      notifyListeners(); // บอก Widget ที่ฟังอยู่ให้เปลี่ยนหน้า
    });
  }

  UserEntity? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<void> logout() async {
    // ลบ FCM token และ unsubscribe topics ก่อน logout
    if (_user != null) {
      try {
        await _notificationService.unsubscribeFromTopic('user_${_user!.id}');
        await _notificationService.deleteToken();
        debugPrint("FCM Token deleted for user: ${_user!.id}");
      } catch (e) {
        debugPrint("Failed to delete FCM Token: $e");
      }
    }
    
    await _authRepository.logout();
  }

  Future<void> _setupFCMToken(String userId) async {
    try {
      await _setupNotificationsUseCase.execute(userId);
      
      // Subscribe to user-specific topic
      await _notificationService.subscribeToTopic('user_$userId');
      
      debugPrint("FCM Token setup completed for user: $userId");
    } catch (e) {
      debugPrint("Failed to setup FCM Token: $e");
    }
  }
}