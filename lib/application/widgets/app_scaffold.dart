import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onNavigationChanged;
  final Widget child;

  const AppScaffold({
    super.key,
    this.currentIndex = 0,
    this.onNavigationChanged,
    required this.child,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.map, label: 'Map', index: 0),
              _buildNavItem(
                icon: Icons.add_circle,
                label: 'Report',
                index: 1,
                isCenter: true,
              ),
              _buildNavItem(icon: Icons.history, label: 'History', index: 2),
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
    bool isCenter = false,
  }) {
    final isSelected = widget.currentIndex == index;
    final color = isSelected ? const Color(0xFFF99305) : Colors.white;

    return InkWell(
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
        ],
      ),
    );
  }
}
