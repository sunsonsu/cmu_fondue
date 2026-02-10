import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/pages/map_viewer_page.dart';
import 'package:cmu_fondue/application/pages/reporting_page.dart';
import 'package:cmu_fondue/application/pages/history_page.dart';
import 'package:cmu_fondue/application/widgets/app_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    MapViewerPage(),
    ReportingPage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: _currentIndex,
      onNavigationChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      child: IndexedStack(index: _currentIndex, children: _pages),
    );
  }
}
