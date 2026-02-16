import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/pages/select_place_page.dart';

class ReportingPage extends StatelessWidget {
  const ReportingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Section (Full Screen)
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[200],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Map View',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Google Maps will be displayed here',
                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
              ],
            ),
          ),
        ),

        // Draggable Problems Bottom Sheet
        const SelectPlaceBottomSheet(),
      ],
    );
  }
}
