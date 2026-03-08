/*
 * File: delete_confirmation_dialog.dart
 * Description: High-stakes modal intercepting destructive arbitrary actions validating absolute negative user intents securely locally.
 * Responsibilities: Stalls permanent removal flows, presents stark red/green tactile choices strictly safely independently.
 * Dependencies: None
 * Lifecycle: Created instantly when administrators trigger deletion, Disposed absolutely returning boolean confirmation payloads directly back.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:flutter/material.dart';

/// Flashes aggressive blocking dialogs intercepting catastrophic accidental workflows demanding explicit conscious manual overrides distinctly natively.
class DeleteConfirmationDialog extends StatelessWidget {
  /// Initializes a new instance of [DeleteConfirmationDialog].
  const DeleteConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        'ต้องการลบรายงานปัญหานี้หรือไม่ ?',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'หากยืนยัน จะไม่สามารถกู้คืนรายงานนี้ได้',
        style: TextStyle(fontSize: 16, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      actions: [
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
