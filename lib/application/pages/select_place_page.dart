import 'package:cmu_fondue/application/widgets/submit_location_bottom_sheet.dart';
import 'package:cmu_fondue/data/repositories/cmu_place_repo_impl.dart';
import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';
import 'package:cmu_fondue/domain/usecases/cmu_place_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/location_search.dart';
import 'package:cmu_fondue/application/widgets/map_widget.dart';
import 'package:geocoding/geocoding.dart';

class SelectPlaceBottomSheet extends StatefulWidget {
  const SelectPlaceBottomSheet({super.key});

  @override
  State<SelectPlaceBottomSheet> createState() => _SelectPlaceBottomSheetState();
}

class _SelectPlaceBottomSheetState extends State<SelectPlaceBottomSheet> {
  String? _selectedPlace;

  late CmuPlaceUsecase _cmuPlaceUsecase;

  List<CmuPlaceEntity> _cmuPlaces = [];
  bool _isLoading = true;

  final ValueNotifier<List<CmuPlaceEntity>?> _placemarkNotifier = ValueNotifier(
    null,
  );

  @override
  void initState() {
    super.initState();
    _initDependencies();
    _refreshData();
  }

  void _initDependencies() {
    final repo = CmuPlaceRepoImpl();
    _cmuPlaceUsecase = CmuPlaceUsecase(repo);
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    try {
      final result = await _cmuPlaceUsecase.getCmuPlaces();
      setState(() {
        _cmuPlaces = result;
      });
    } catch (e) {
      _showErrorSnackBar("โหลดข้อมูลไม่สำเร็จ: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _placemarkNotifier.dispose();
    super.dispose();
  }

  void _onLocationSelected(Placemark place) {
    setState(() {
      _selectedPlace = place.name;
      if (kDebugMode) {
        print("This is a selected place: $_selectedPlace");
      }
    });

    if (place.name != null) {
      try {
        final selectedEntity = _cmuPlaces.firstWhere(
          (element) => element.name == place.name,
        );
        _placemarkNotifier.value = [selectedEntity];
      } catch (e) {
        if (kDebugMode) {
          print("Place not found: ${place.name}");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        title: const Text(
          'เลือกตำแหน่ง',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D3891),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Stack(
          children: [
            // Main Content - Map (Full height)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    // Map
                    Positioned.fill(
                      child: MapSubmitWidget(
                        onPlacemarkChanged: (placemark) =>
                            _placemarkNotifier.value = placemark,
                        selectedPlace:
                            _placemarkNotifier.value?.isNotEmpty == true
                            ? _placemarkNotifier.value!.first
                            : null,
                      ),
                    ),

                    // Bottom Sheet
                    SubmitLocationBottomSheet(
                      locationNotifier: _placemarkNotifier,
                    ),
                  ],
                ),
              ),
            ),

            // Floating Search Section (On top)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Description text
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ค้นหาตำแหน่งในช่องค้นหา หรือ เลือกตำแหน่งจากแผนที่',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),

                    // Location Search Widget
                    LocationSearchWidget(
                      locations: _cmuPlaces.map((e) => e.name).toList(),
                      onLocationSelected: _onLocationSelected,
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
