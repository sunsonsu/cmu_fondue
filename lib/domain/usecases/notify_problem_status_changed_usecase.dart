// lib/domain/usecases/notify_problem_status_changed_usecase.dart
import 'package:cmu_fondue/data/services/cloud_functions_service.dart';

// Komsan
class NotifyProblemStatusChangedUseCase {
  final CloudFunctionsService _cloudFunctionsService;

  NotifyProblemStatusChangedUseCase(this._cloudFunctionsService);

  /// เรียกใช้หลังจาก Admin เปลี่ยนสถานะ Problem แล้ว
  /// 
  /// Parameters:
  /// - problemId: ID ของ Problem ที่เปลี่ยนสถานะ
  /// - problemTitle: ชื่อปัญหา
  /// - newTagName: ชื่อสถานะใหม่ (เช่น "รอดำเนินการ", "กำลังดำเนินการ")
  /// - fcmToken: FCM Token ของเจ้าของปัญหา (reporter)
  Future<void> execute({
    required String problemId,
    required String problemTitle,
    required String newTagName,
    required String fcmToken,
  }) async {
    if (fcmToken.isEmpty) {
      // ถ้าไม่มี FCM token ก็ไม่ต้องส่ง
      return;
    }

    await _cloudFunctionsService.sendProblemStatusNotification(
      problemId: problemId,
      problemTitle: problemTitle,
      newTagName: newTagName,
      fcmToken: fcmToken,
    );
  }
}
