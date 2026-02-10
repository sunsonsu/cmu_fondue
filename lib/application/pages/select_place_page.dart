import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/pages/assigned_problems_page.dart';
import 'package:cmu_fondue/application/widgets/location_search.dart';

class SelectPlaceBottomSheet extends StatefulWidget {
  const SelectPlaceBottomSheet({super.key});

  @override
  State<SelectPlaceBottomSheet> createState() => _SelectPlaceBottomSheetState();
}

class _SelectPlaceBottomSheetState extends State<SelectPlaceBottomSheet> {
  String? _selectedPlace;

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
            child: Column(
              children: [
                // Map placeholder
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        // Map placeholder with icon
                        Center(
                          child: Icon(
                            Icons.map,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                        ),
                        // Location marker in center
                        Center(
                          child: Icon(
                            Icons.location_on,
                            size: 48,
                            color: Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Your Location info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Location',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedPlace ??
                            'QXX3+8FQ, Suthep, Mueang Chiang Mai District, Chiang Mai 50200',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.05),
              //     blurRadius: 4,
              //     offset: const Offset(0, -2),
              //   ),
              // ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedPlace != null
                      ? () {
                          // Navigate to assigned problems page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssignedProblemsPage(
                                location: _selectedPlace!,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: const Color(0xFF5D3891),
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                  child: Text(
                    'เลือกตำแหน่งนี้',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _selectedPlace != null
                          ? Colors.white
                          : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
