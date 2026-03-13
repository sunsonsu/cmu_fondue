/*
 * File: app_page.dart
 * Description: The primary architectural container anchoring horizontal tab navigation for the entire application.
 * Responsibilities:
 * - Manages the main routing indexes swapping between various destination screens.
 * - Synchronizes the navigation state between the navigation bar and the visible page content.
 * - Determines the appropriate user profile or admin view based on authentication roles.
 * Author: Rachata 650510638 & Chananchida 650510659
 * Course: Mobile Application Development Framework
 * Lifecycle: Created instantly post-login upon authentication stream resolution, Disposed alongside session invalidation.
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
///
/// Uses an [IndexedStack] to preserve the state of sub-pages like [MapViewerPage],
/// [SelectPlaceBottomSheet], and [HistoryPage] while navigating via the [AppScaffold].
class HomePage extends StatefulWidget {
  /// The starting destination pane index selected natively upon launch.
  final int initialIndex;

  /// Initializes a new instance of [HomePage].
  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// The current index representing the active page in the bottom navigation.
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
