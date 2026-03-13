/*
 * File: custom_snackbar.dart
 * Description: Universal feedback dispatcher orchestrating transient visual notifications independently from specific rendering scopes cleanly seamlessly.
 * Responsibilities: Isolates exact contextual scaffolding streams, pushes formatted messages broadly quickly securely checking contextual active lifetimes cleanly unconditionally.
 * Dependencies: None
 * Lifecycle: Created merely when explicitly flashing notifications rapidly, Disposed instantaneously expiring.
 * Author: Chananchida 650510659
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
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _TopSnackBar(
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
        duration: duration,
        onDismiss: () => entry.remove(),
      ),
    );
    overlay.insert(entry);
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

class _TopSnackBar extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Duration duration;
  final VoidCallback onDismiss;

  const _TopSnackBar({
    required this.message,
    required this.icon,
    required this.backgroundColor,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_TopSnackBar> createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<_TopSnackBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();

    Future.delayed(widget.duration, () async {
      if (mounted) {
        await _controller.reverse();
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Positioned(
      top: topPadding + 12,
      right: 16,
      left: 16,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
