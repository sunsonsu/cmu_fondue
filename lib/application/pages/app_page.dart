import 'package:cmu_fondue/application/pages/profile_page.dart';
import 'package:cmu_fondue/application/pages/admin_page.dart';
import 'package:cmu_fondue/application/pages/select_place_page.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/pages/map_viewer_page.dart';
import 'package:cmu_fondue/application/pages/history_page.dart';
import 'package:cmu_fondue/application/widgets/app_scaffold.dart';
import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;

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
