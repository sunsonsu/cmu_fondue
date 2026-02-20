// lib/domain/usecases/setup_notifications_usecase.dart
import 'package:cmu_fondue/data/services/notification_service.dart';
import 'package:cmu_fondue/domain/repositories/user_repo.dart';

class SetupNotificationsUseCase {
  final NotificationService notificationService;
  final UserRepo userRepository;

  SetupNotificationsUseCase(this.notificationService, this.userRepository);

  Future<void> execute(String userId) async {
    final token = await notificationService.getFcmToken();
    if (token != null) {
      await userRepository.updateFcmToken(userId, token);
    }
  }
}