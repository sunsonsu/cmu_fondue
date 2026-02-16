import 'package:cmu_fondue/application/widgets/submit_location_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/pages/assigned_problems_page.dart';
import 'package:cmu_fondue/application/widgets/location_search.dart';
import 'package:cmu_fondue/application/widgets/map_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class SelectPlaceBottomSheet extends StatefulWidget {
  const SelectPlaceBottomSheet({super.key});

  @override
  State<SelectPlaceBottomSheet> createState() => _SelectPlaceBottomSheetState();
}

class _SelectPlaceBottomSheetState extends State<SelectPlaceBottomSheet> {
  String? _selectedPlace;
  final ValueNotifier<List<Placemark>?> _placemarkNotifier = ValueNotifier(
    null,
  );
  @override
  void dispose() {
    _placemarkNotifier.dispose();
    super.dispose();
  }

  // Mock data - สถานที่ในมช.
  final List<String> _cmuPlaces = [
    'หอสมุดกลาง มหาวิทยาลัยเชียงใหม่',
    'คณะวิศวกรรมศาสตร์',
    'คณะวิทยาศาสตร์',
    'คณะมนุษยศาสตร์',
    'คณะสังคมศาสตร์',
    'คณะแพทยศาสตร์',
    'คณะเกษตรศาสตร์',
    'คณะบริหารธุรกิจ',
    'คณะครุศาสตร์',
    'โรงอาหารกลาง',
    'สนามกีฬากลาง 700 ปี',
    'อาคารเรียนรวม',
    'หอประชุม มช.',
    'Computer Science Building',
    'Computer Engineering Building',
    'Department of Computer Science Building',
  ];

  void _onLocationSelected(String place) {
    setState(() {
      _selectedPlace = place.isEmpty ? null : place;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'เลือกตำแหน่ง',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Description text
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 8, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ค้นหาตำแหน่งในช่องค้นหา หรือ เลือกตำแหน่งจากแผนที่',
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
            ),
          ),

          // Location Search Widget
          LocationSearchWidget(
            locations: _cmuPlaces,
            onLocationSelected: _onLocationSelected,
          ),

          const SizedBox(height: 8),

          // Main Content - Map
          Expanded(
            child: Stack(
              children: [
                // Map
                Positioned.fill(
                  child: MapSubmitWidget(
                    onPlacemarkChanged: (placemark) =>
                        _placemarkNotifier.value = placemark,
                  ),
                ),

                // Bottom Sheet
                SubmitLocationBottomSheet(locationNotifier: _placemarkNotifier),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
