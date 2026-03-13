/*
 * File: cloud_functions_service.dart
 * Description: Wrapper for executing remote Firebase Cloud Functions.
 * Responsibilities: Acts as a central dispatcher for invoking secure serverless backend logic securely.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

/// Routes triggers explicitly designed to activate serverless logic hooks within Google Cloud.
class CloudFunctionsService {
  /// The client SDK instance pinned explicitly to the `us-central1` environment.
  final FirebaseFunctions _functions = 
      FirebaseFunctions.instanceFor(region: 'us-central1');

  /// The shared singleton instance.
  static final CloudFunctionsService _instance =
      CloudFunctionsService._internal();
      
  /// Retrieves the unified singleton instance of [CloudFunctionsService].
  factory CloudFunctionsService() => _instance;
  
  /// Privately provisions the singleton state.
  CloudFunctionsService._internal();

  /// Invokes the HTTPS callable function responsible for distributing push notifications.
  ///
  /// This operates asynchronously over the network.
  /// Dispatches the signal utilizing the reporter's specific [fcmToken]. Includes
  /// the [problemId] and [problemTitle] for deep linking, while [newTagName]
  /// clarifies the updated status parameter.
  /// Throws an exception if the cloud invocation fails or rejects the payload.
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
