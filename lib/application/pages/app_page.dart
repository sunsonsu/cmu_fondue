/*
 * File: app_page.dart
 * Description: The primary architectural container anchoring horizontal tab navigation.
 * Responsibilities: Manages main routing indexes swapping between map, reports, history, and profile screens seamlessly.
 * Dependencies: ProfilePage, AdminPage, SelectPlaceBottomSheet, MapViewerPage, HistoryPage, AppScaffold, AppAuthProvider
 * Lifecycle: Created instantly post-login upon authentication stream resolution, Disposed alongside session invalidation.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/pages/profile_page.dart';
import 'package:cmu_fondue/application/pages/admin_page.dart';
import 'package:cmu_fondue/application/pages/select_place_page.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/pages/map_viewer_page.dart';
import 'package:cmu_fondue/application/pages/history_page.dart';
import 'package:cmu_fondue/application/widgets/app_scaffold.dart';
import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:provider/provider.dart';

/// Hosts the root navigation paradigm connecting global destination widgets dynamically.
class HomePage extends StatefulWidget {
  /// The starting destination pane index selected natively upon launch.
  final int initialIndex;

  /// Initializes a new instance of [HomePage].
  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AppAuthProvider>();
    final isAdmin = authProvider.user?.isAdmin ?? false;

    final List<Widget> pages = [
      const MapViewerPage(),
      const SelectPlaceBottomSheet(),
      const HistoryPage(),
      isAdmin ? const AdminPage() : const ProfilePage(),
    ];

    return AppScaffold(
      currentIndex: _currentIndex,
      profileLabel: isAdmin ? 'Admin' : 'Profile',
      onNavigationChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      child: IndexedStack(index: _currentIndex, children: pages),
    );
  }
}
