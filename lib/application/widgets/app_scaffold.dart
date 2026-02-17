import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onNavigationChanged;
  final Widget child;
  final String profileLabel;

  const AppScaffold({
    super.key,
    this.currentIndex = 0,
    this.onNavigationChanged,
    required this.child,
    this.profileLabel = 'Profile',
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final GlobalKey _containerKey = GlobalKey();
  final List<GlobalKey> _navKeys = List.generate(4, (_) => GlobalKey());
  double _indicatorLeft = 0;
  bool _showIndicator = false;
  static const double _indicatorWidth = 40.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIndicatorPosition();
    });
  }

  @override
  void didUpdateWidget(AppScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateIndicatorPosition();
      });
    }
  }

  void _updateIndicatorPosition() {
    final navKey = _navKeys[widget.currentIndex];
    final containerKey = _containerKey;

    if (navKey.currentContext != null && containerKey.currentContext != null) {
      final RenderBox navBox = navKey.currentContext!.findRenderObject() as RenderBox;
      final RenderBox containerBox = containerKey.currentContext!.findRenderObject() as RenderBox;
      
      final navPosition = navBox.localToGlobal(Offset.zero);
      final containerPosition = containerBox.localToGlobal(Offset.zero);
      final navWidth = navBox.size.width;
      
      setState(() {
        _indicatorLeft = (navPosition.dx - containerPosition.dx) + (navWidth - _indicatorWidth) / 2;
        _showIndicator = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF5D3891),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Stack(
            key: _containerKey,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    icon: Icons.map,
                    label: 'Map',
                    index: 0,
                    navKey: _navKeys[0],
                  ),
                  _buildNavItem(
                    icon: Icons.add_circle,
                    label: 'Report',
                    index: 1,
                    isCenter: true,
                    navKey: _navKeys[1],
                  ),
                  _buildNavItem(
                    icon: Icons.history,
                    label: 'History',
                    index: 2,
                    navKey: _navKeys[2],
                  ),
                  _buildNavItem(
                    icon: widget.profileLabel == 'Admin' 
                        ? Icons.admin_panel_settings 
                        : Icons.person,
                    label: widget.profileLabel,
                    index: 3,
                    navKey: _navKeys[3],
                  ),
                ],
              ),
              // Animated indicator
              if (_showIndicator)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  bottom: 0,
                  left: _indicatorLeft,
                  child: Container(
                    height: 3,
                    width: _indicatorWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF99305),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required GlobalKey navKey,
    bool isCenter = false,
  }) {
    final isSelected = widget.currentIndex == index;
    final color = isSelected ? const Color(0xFFF99305) : Colors.white;

    return InkWell(
      key: navKey,
      onTap: () => widget.onNavigationChanged?.call(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: isCenter ? 32 : 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 7), // Space for indicator
        ],
      ),
    );
  }
}
