/*
 * File: admin_page.dart
 * Description: The primary root dashboard presented purely to authenticated system administrators to oversee system health and reports.
 * Responsibilities: 
 * - Hosts the top-level application bar with navigation and profile actions.
 * - Injects the [StaffDashboard] interactive region for data visualization and management.
 * - Manages the high-level layout for the administrative view.
 * Author: Apiwit 650510648 & Chananchida 650510659
 * Course: Mobile Application Development Framework
 * Lifecycle: Created via [IndexedStack] in [HomePage], Disposed when the application closes or the user logs out.
 */

import 'package:cmu_fondue/application/widgets/profile_button.dart';
import 'package:cmu_fondue/application/widgets/staff_dashboard.dart';
import 'package:flutter/material.dart';

/// The high-level scaffold organizing administrative capabilities distinctly from standard citizen views.
///
/// Provides a structured environment for staff members to review reported issues,
/// analyze statistics, and perform administrative overrides through the [StaffDashboard].
class AdminPage extends StatelessWidget {
  /// Initializes a new instance of [AdminPage].
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        title: const Text(
          'ภาพรวมระบบ',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D3891),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12), child: ProfileButton()),
        ],
      ),
      body: const StaffDashboard(),
    );
  }
}
