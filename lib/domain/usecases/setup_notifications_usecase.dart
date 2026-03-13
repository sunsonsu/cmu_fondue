/*
 * File: setup_notifications_usecase.dart
 * Description: Use case for gathering and anchoring device push tokens to personal accounts.
 * Responsibilities: Interrogates the device for a token and then pushes it upstream to the user's database entry.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/data/services/notification_service.dart';
import 'package:cmu_fondue/domain/repositories/user_repo.dart';

/// Provides automated business logic to bootstrap push capabilities immediately after login.
class SetupNotificationsUseCase {
  /// The dependent local service fetching physical device ids.
  final NotificationService notificationService;

  /// The dependent remote service preserving the assignment.
  final UserRepo userRepository;

  /// Initializes a new instance of [SetupNotificationsUseCase].
  SetupNotificationsUseCase(this.notificationService, this.userRepository);

  /// Attempts to fetch a local token and tether it remotely via [userId].
  ///
  /// This operates asynchronously performing remote patching if a token is successfully generated.
  Future<void> execute(String userId) async {
    final token = await notificationService.getFcmToken();
    if (token != null) {
      await userRepository.updateFcmToken(userId, token);
    }
  }
}
