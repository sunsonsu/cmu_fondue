import 'package:cmu_fondue/data/repositories/cmu_place_repo_impl.dart';
import 'package:cmu_fondue/domain/usecases/cmu_place_usecase.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  bool _isInsideCmu = false;

  @override
  void initState() {
    super.initState();
    _checkLocation();
  }

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.map, label: 'Map', index: 0),
              _buildNavItem(
                icon: Icons.add_circle,
                label: 'Report',
                index: 1,
                isCenter: true,
                enabled: _isInsideCmu,
              ),
              _buildNavItem(icon: Icons.history, label: 'History', index: 2),
              _buildNavItem(icon: Icons.person, label: 'Profile', index: 3),
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
    bool enabled = true,
  }) {
    final isSelected = widget.currentIndex == index;
    final color = enabled
        ? (isSelected ? const Color(0xFFF99305) : Colors.white)
        : Colors.grey;

    return InkWell(
      onTap: () {
        if (enabled) {
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
        ],
      ),
    );
  }
}
