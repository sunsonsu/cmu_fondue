import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

// Komsan
class CloudFunctionsService {
  // ระบุ region ให้ตรงกับที่ deploy (us-central1)
  final FirebaseFunctions _functions = 
      FirebaseFunctions.instanceFor(region: 'us-central1');

  // Singleton pattern
  static final CloudFunctionsService _instance =
      CloudFunctionsService._internal();
  factory CloudFunctionsService() => _instance;
  CloudFunctionsService._internal();

  /// ส่ง notification เมื่อมีการเปลี่ยนสถานะของ Problem
  Future<void> sendProblemStatusNotification({
    required String problemId,
    required String problemTitle,
    required String newTagName,
    required String fcmToken,
  }) async {
    if (kDebugMode) {
      print('🔔 Sending notification for problem: $problemId');
    }
    
    try {

      final callable =
          _functions.httpsCallable('sendProblemStatusNotification');

      final result = await callable.call({
        'problemId': problemId,
        'problemTitle': problemTitle,
        'newTagName': newTagName,
        'fcmToken': fcmToken,
      });

      if (kDebugMode) {
        print('✅ Notification sent successfully: ${result.data}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error calling cloud function: $e');
      }
      rethrow;
    }
  }
}
