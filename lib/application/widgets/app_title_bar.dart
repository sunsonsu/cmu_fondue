/*
 * File: app_title_bar.dart
 * Description: High-level visual identity band rendering universal application branding statically.
 * Responsibilities: Isolates header logic uniquely providing fixed pathways jumping across deep user profile configurations easily cleanly.
 * Dependencies: ProfilePage
 * Lifecycle: Created invariably aligning top screens consistently natively, Disposed explicitly switching global layouts.
 * Author: Chananchida 650510659
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/pages/profile_page.dart';
import 'package:flutter/material.dart';

/// Wraps simple static identification assets allowing explicit global user setting paths universally gracefully.
class AppTitleBar extends StatelessWidget {
  /// Initializes a new instance of [AppTitleBar].
  const AppTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF5D3891),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'CMU Fondue',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            // Profile Button
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              icon: const Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 35,
              ),
              tooltip: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
