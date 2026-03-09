/*
 * File: select_place_page.dart
 * Description: Geolocation pinpointing tool binding raw manual searching algorithms directly into tactile map movements enforcing bounding boundaries strictly natively.
 * Responsibilities: Filters valid queries securely, intercepts arbitrary touches gracefully validating coordinates strictly against static limits seamlessly.
 * Dependencies: CmuPlaceUsecase, SubmitLocationBottomSheet, MapSubmitWidget, LocationSearchWidget
 * Lifecycle: Created upon router switching dynamically, Disposed automatically retreating out from creation stacks.
 * Author: Chananchida
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/widgets/submit_location_bottom_sheet.dart';
import 'package:cmu_fondue/data/repositories/cmu_place_repo_impl.dart';
import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';
import 'package:cmu_fondue/domain/usecases/cmu_place_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/location_search.dart';
import 'package:cmu_fondue/application/widgets/map_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Synthesizes tactile Google map structures bridging text queries backwards towards strictly bounded geographical coordinates elegantly.
class SelectPlaceBottomSheet extends StatefulWidget {
  /// Initializes a new instance of [SelectPlaceBottomSheet].
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

  final TextEditingController _searchController = TextEditingController();
  bool _isProgrammaticMove = false;
  bool _isFirstLoad = true;

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

  /// Pulls authoritative bounding landmarks remotely fetching entirely new constraint arrays distinctly.
  ///
  /// This operates asynchronously demanding formal explicit queries hooking domain logic correctly masking delays gracefully.
  ///
  /// Side effects:
  /// Rewrites active [_cmuPlaces] comprehensively upon fetching cleanly directly firing [setState].
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

  /// Projects restrictive system alerts punishing errant geographical selections violently disrupting creation flow deliberately.
  void _showNotInCmuDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ไม่อนุญาต'),
        content: const Text('สถานที่ที่เลือกอยู่นอกเขตมหาวิทยาลัยเชียงใหม่'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _moveToUserLocation();
            },
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  Future<void> _moveToUserLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          timeLimit: Duration(seconds: 5),
        ),
      );
      _setLocationToPosition(position.latitude, position.longitude);
    } catch (e) {
      try {
        final position = await Geolocator.getLastKnownPosition();
        if (position != null) {
          _setLocationToPosition(position.latitude, position.longitude);
          return;
        }
      } catch (_) {}

      final cmuLatLng = const LatLng(18.798946, 98.953114);
      _setLocationToPosition(cmuLatLng.latitude, cmuLatLng.longitude);
    }
  }

  void _setLocationToPosition(double lat, double lng) async {
    try {
      await setLocaleIdentifier("th_TH");
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final entity = CmuPlaceEntity.fromPlacemark(
          placemarks.first,
          LatLng(lat, lng),
        );
        setState(() {
          _isProgrammaticMove = true;
          _placemarkNotifier.value = [entity];
        });
        return;
      }
    } catch (_) {}

    final entity = CmuPlaceEntity(
      name: 'ตำแหน่งปัจจุบัน',
      lat: lat,
      lng: lng,
      formattedAddress: 'ตำแหน่งของคุณ',
    );
    setState(() {
      _isProgrammaticMove = true;
      _placemarkNotifier.value = [entity];
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _placemarkNotifier.dispose();
    super.dispose();
  }

  /// Validates textual landmark selections explicitly filtering coordinates dynamically rejecting errant values totally identically natively.
  void _onLocationSelected(Placemark place) {
    setState(() {
      _selectedPlace = place.name;
      if (kDebugMode) {
        print("This is a selected place: $_selectedPlace");
      }
    });

    if (place.name != null && place.name!.isNotEmpty) {
      try {
        final selectedEntity = _cmuPlaces.firstWhere(
          (element) => element.name == place.name,
        );

        if (!_cmuPlaceUsecase.isInsideCmu(
          LatLng(selectedEntity.lat, selectedEntity.lng),
        )) {
          _showNotInCmuDialog();
          _placemarkNotifier.value = null;
          return;
        }

        if (_placemarkNotifier.value == null ||
            _placemarkNotifier.value!.isEmpty ||
            _placemarkNotifier.value!.first.name != selectedEntity.name) {
          _isProgrammaticMove = true;
        }

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
        child: Column(
          children: [
            // Search bar section — always on top, never overlapped
            Container(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ค้นหาตำแหน่งในช่องค้นหา หรือ เลือกตำแหน่งจากแผนที่',
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      ),
                    ),
                  ),

                  LocationSearchWidget(
                    searchController: _searchController,
                    locations: _cmuPlaces.map((e) => e.name).toList(),
                    onLocationSelected: _onLocationSelected,
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),

            // Map + bottom sheet constrained below the search bar
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: MapSubmitWidget(
                      onPlacemarkChanged: (placemark) {
                        if (placemark.isNotEmpty) {
                          final entity = placemark.first;
                          if (!_cmuPlaceUsecase.isInsideCmu(
                            LatLng(entity.lat, entity.lng),
                          )) {
                            if (_isFirstLoad) {
                              _isFirstLoad = false;
                              _moveToUserLocation();
                              _placemarkNotifier.value = null;
                              return;
                            } else if (!_isProgrammaticMove) {
                              _showNotInCmuDialog();
                              _placemarkNotifier.value = null;
                              return;
                            } else {
                              _placemarkNotifier.value = null;
                            }
                          }
                          _isFirstLoad = false;
                        }

                        if (!_isProgrammaticMove) {
                          _searchController.clear();
                        } else {
                          _isProgrammaticMove = false;
                        }
                        _placemarkNotifier.value = placemark;
                      },
                      selectedPlace:
                          _placemarkNotifier.value?.isNotEmpty == true
                          ? _placemarkNotifier.value!.first
                          : null,
                    ),
                  ),

                  SubmitLocationBottomSheet(
                    locationNotifier: _placemarkNotifier,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
