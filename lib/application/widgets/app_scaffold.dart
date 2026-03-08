/*
 * File: app_scaffold.dart
 * Description: The primary architectural container anchoring global navigation persistently across distinct high-level views seamlessly.
 * Responsibilities: Injects universal bottom bar routing, restricts creation pathways leveraging bounded geolocation natively, and isolates common view padding safely.
 * Dependencies: CmuPlaceUsecase, Geolocator, Google Maps Flutter
 * Lifecycle: Created merely upon initial authorized session setup, Disposed never unless sessions log out explicitly.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/data/repositories/cmu_place_repo_impl.dart';
import 'package:cmu_fondue/domain/usecases/cmu_place_usecase.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Unifies standard page routing maintaining continuous visual states navigating deep logical paths reliably.
class AppScaffold extends StatefulWidget {
  /// The active highlighted routing index currently anchoring view layouts locally natively.
  final int currentIndex;

  /// Receives distinct integer payloads broadcasting external routing requests formally immediately.
  final Function(int)? onNavigationChanged;

  /// The isolated dynamic payload occupying structural empty bodies completely seamlessly.
  final Widget child;

  /// The static custom naming applying visual distinctions matching user roles exactly transparently.
  final String profileLabel;

  /// Initializes a new instance of [AppScaffold].
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
  bool _isInsideCmu = false;
  static const double _indicatorWidth = 40.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIndicatorPosition();
    });
    _checkLocation();
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

  /// Evaluates precise physical bounding boxes snapping graphical indicator limits dynamically across layout streams perfectly.
  ///
  /// Side effects:
  /// Rewrites active graphical variables specifically assigning visual positions mutating view models actively invoking [setState].
  void _updateIndicatorPosition() {
    final navKey = _navKeys[widget.currentIndex];
    final containerKey = _containerKey;

    if (navKey.currentContext != null && containerKey.currentContext != null) {
      final RenderBox navBox =
          navKey.currentContext!.findRenderObject() as RenderBox;
      final RenderBox containerBox =
          containerKey.currentContext!.findRenderObject() as RenderBox;

      final navPosition = navBox.localToGlobal(Offset.zero);
      final containerPosition = containerBox.localToGlobal(Offset.zero);
      final navWidth = navBox.size.width;

      setState(() {
        _indicatorLeft =
            (navPosition.dx - containerPosition.dx) +
            (navWidth - _indicatorWidth) / 2;
        _showIndicator = true;
      });
    }
  }

  /// Enforces geographical isolation mapping user paths intercepting outside limits correctly blocking invalid creation flows.
  ///
  /// This operates asynchronously initiating deep architecture queries securely hooking local operating systems distinctly isolating failures gracefully.
  ///
  /// Side effects:
  /// Updates local [_isInsideCmu] constraints totally limiting specific system abilities unconditionally natively.
  Future<void> _checkLocation() async {
    try {
      final repo = CmuPlaceRepoImpl();
      final usecase = CmuPlaceUsecase(repo);

      final position = await Geolocator.getCurrentPosition();
      final userLocation = LatLng(position.latitude, position.longitude);

      if (mounted) {
        setState(() {
          _isInsideCmu = usecase.isInsideCmu(userLocation);
        });
      }
    } catch (e) {
      debugPrint("Error checking location: $e");
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
                    enabled: _isInsideCmu,
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
    bool enabled = true,
  }) {
    final isSelected = widget.currentIndex == index;
    final color = enabled
        ? (isSelected ? const Color(0xFFF99305) : Colors.white)
        : Colors.grey;

    return InkWell(
      key: navKey,
      onTap: () {
        if (enabled || index != 1) {
          // Only block and show error on the 'Report' tab (index 1)
          widget.onNavigationChanged?.call(index);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              icon: const Icon(
                Icons.error_outline,
                color: Color(0xFF4D2161),
                size: 48,
              ),
              content: const Text(
                'ไม่สามารถแจ้งปัญหาได้ เนื่องจากคุณอยู่นอกเขตมหาวิทยาลัยเชียงใหม่',
                textAlign: TextAlign.center,
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4D2161),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('ตกลง'),
                ),
              ],
            ),
          );
        }
      },
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
