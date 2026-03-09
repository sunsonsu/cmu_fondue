/*
 * File: auth_provider.dart
 * Description: State management provider controlling application-wide authentication status.
 * Responsibilities: Holds the current user state, exposes authorization flags, and manages reactive FCM token configurations.
 * Author: Rachata, Komsan
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/usecases/setup_notifications_usecase.dart';
import 'package:cmu_fondue/data/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/domain/entities/user_entity.dart';
import 'package:cmu_fondue/domain/repositories/auth_repo.dart';

/// Administers reactive state broadcasting for identity management across the app hierarchy.
class AppAuthProvider extends ChangeNotifier {
  /// The dependent repository supplying raw identity streams.
  final AuthRepository _authRepository;

  /// The specific use case responsible for bootstrapping initial token connections.
  final SetupNotificationsUseCase _setupNotificationsUseCase;

  /// The internal service resolving targeted push topic assignments.
  final NotificationService _notificationService = NotificationService();

  /// The current, active user instance if authenticated.
  UserEntity? _user;

  /// Whether the initial stream connection is currently resolving.
  bool _isLoading = true;

  /// Whether auth state changes should be suppressed (e.g. during registration).
  bool _suppressAuthState = false;

  /// Whether the currently signed-in individual holds elevated system privileges.
  bool get isAdmin => _user?.isAdmin ?? false;

  /// Initializes a new instance of [AppAuthProvider].
  ///
  /// Requires the [_authRepository] to furnish state changes and [_setupNotificationsUseCase]
  /// to configure local device tokens properly upon login sequences.
  AppAuthProvider(this._authRepository, this._setupNotificationsUseCase) {
    _authRepository.authStateChanges().listen((user) {
      if (_suppressAuthState) return;

      _user = user;
      _isLoading = false;

      if (user != null) {
        _setupFCMToken(user.id);
      }

      notifyListeners();
    });
  }

  /// The active identity entity model, or null if the session is absent.
  UserEntity? get user => _user;

  /// Whether the initial backend authentication ping is actively blocking.
  bool get isLoading => _isLoading;

  /// Whether an active identity session is conclusively verified.
  bool get isAuthenticated => _user != null;

  /// Sets whether auth state changes should be suppressed.
  set suppressAuthState(bool value) => _suppressAuthState = value;

  /// Discards the active identity terminating both local and remote session links.
  ///
  /// This operates asynchronously dispatching upstream disconnects.
  /// Gracefully absorbs failures during targeted unsubscriptions to ensure core logging out completes.
  ///
  /// Side effects:
  /// Nullifies [_user], drops local Push Token capabilities, and fires [notifyListeners].
  Future<void> logout() async {
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
    notifyListeners();
  }

  /// Establishes the necessary cloud messaging linkages utilizing [userId].
  ///
  /// This operates asynchronously initiating a device token grab.
  /// Safe to ignore internally caught failures.
  Future<void> _setupFCMToken(String userId) async {
    try {
      await _setupNotificationsUseCase.execute(userId);
      await _notificationService.subscribeToTopic('user_$userId');
      debugPrint("FCM Token setup completed for user: $userId");
    } catch (e) {
      debugPrint("Failed to setup FCM Token: $e");
    }
  }
}
