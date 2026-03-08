/*
 * File: custom_snackbar.dart
 * Description: Universal feedback dispatcher orchestrating transient visual notifications independently from specific rendering scopes cleanly seamlessly.
 * Responsibilities: Isolates exact contextual scaffolding streams, pushes formatted messages broadly quickly securely checking contextual active lifetimes cleanly unconditionally.
 * Dependencies: None
 * Lifecycle: Created merely when explicitly flashing notifications rapidly, Disposed instantaneously expiring.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:flutter/material.dart';

/// Synthesizes generalized transient feedback pathways exposing static constructors rendering safe identical messages distinctly securely cleanly globally.
class CustomSnackBar {
  /// Casts arbitrary message objects pushing custom notification forms actively catching visual limits deeply natively seamlessly.
  static void show({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.green,
    IconData icon = Icons.check_circle,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          top: 60,
          left: 80,
          right: 16,
          bottom: 690,
        ),
        duration: duration,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  /// Flashes positive confirmation layouts wrapping localized intents visually gracefully safely cleanly transparently.
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
      duration: duration,
    );
  }

  /// Intercepts extreme negative layout contexts pushing aggressive colors signaling serious issues loudly actively automatically.
  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
      duration: duration,
    );
  }

  /// Renders standard informational alerts mapping neutral behaviors precisely cleanly avoiding intrusive interruptions cleanly silently.
  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
      duration: duration,
    );
  }

  /// Prompts moderate warning paths highlighting uncertain situations carefully precisely deliberately flawlessly securely globally.
  static void showWarning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
      duration: duration,
    );
  }
}
