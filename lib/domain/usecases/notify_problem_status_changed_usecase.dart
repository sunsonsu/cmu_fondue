/*
 * File: notify_problem_status_changed_usecase.dart
 * Description: Use case responsible for dispatching change notifications.
 * Responsibilities: Instructs the cloud functions service to send an FCM alert regarding ticket updates.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/data/services/cloud_functions_service.dart';

/// Orchestrates outgoing push notifications typically triggered by administrator actions.
class NotifyProblemStatusChangedUseCase {
  /// The dependent cloud interaction service.
  final CloudFunctionsService _cloudFunctionsService;

  /// Initializes a new instance of [NotifyProblemStatusChangedUseCase].
  NotifyProblemStatusChangedUseCase(this._cloudFunctionsService);

  /// Dispatches a notification informing a citizen their ticket's status has updated.
  ///
  /// This operates asynchronously. The [problemId] ties the deep link, [problemTitle]
  /// gives context, [newTagName] illustrates the latest status, and the [fcmToken] pinpoints the correct device.
  /// Gracefully aborts operations if [fcmToken] is absent.
  Future<void> execute({
    required String problemId,
    required String problemTitle,
    required String newTagName,
    required String fcmToken,
  }) async {
    if (fcmToken.isEmpty) {
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
