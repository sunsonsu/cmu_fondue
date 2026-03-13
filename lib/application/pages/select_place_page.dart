/*
 * File: select_place_page.dart
 * Description: Geolocation pinpointing tool binding raw manual searching algorithms directly into tactile map movements enforcing bounding boundaries strictly natively.
 * Responsibilities: 
 * - Facilitates the selection of a specific [CmuPlaceEntity] for reporting.
 * - Intercepts map interactions to validate coordinates against University boundaries.
 * - Provides immediate feedback via bottom sheets upon successful location locking.
 * Author: Apiwit 650510648 & Chananchida 650510659
 * Course: Mobile Application Development Framework
 * Lifecycle: Created upon router switching dynamically, Disposed automatically retreating out from creation stacks.
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
///
/// Integrates a [LocationSearchWidget] for keyword-based site finding alongside
/// a [MapSubmitWidget] for manual pin drops. Returns selected place metadata
/// to the calling process.
class SelectPlaceBottomSheet extends StatefulWidget {
  /// Initializes a new instance of [SelectPlaceBottomSheet].
  const SelectPlaceBottomSheet({super.key});

  @override
  State<SelectPlaceBottomSheet> createState() => _SelectPlaceBottomSheetState();
}

class _SelectPlaceBottomSheetState extends State<SelectPlaceBottomSheet> {
  /// The reactive name of the currently targeted place.
  String? _selectedPlace;

  /// The domain logic for place retrieval and boundary validation.
  late CmuPlaceUsecase _cmuPlaceUsecase;

  /// The full list of authoritative University landmarks.
  List<CmuPlaceEntity> _cmuPlaces = [];

  /// Notifies listeners of changes to the current placemark candidates.
  final ValueNotifier<List<CmuPlaceEntity>?> _placemarkNotifier = ValueNotifier(
    null,
  );

  /// The controller for the text-based location search input.
  final TextEditingController _searchController = TextEditingController();

  /// Whether the map move was triggered by program code rather than a manual drag.
  bool _isProgrammaticMove = false;

  /// Tracks the first load to handle initial location centering.
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    _initDependencies();
    _refreshData();
  }

  /// Initializes required domain controllers for place handling.
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
    try {
      final result = await _cmuPlaceUsecase.getCmuPlaces();
      setState(() {
        _cmuPlaces = result;
      });
    } catch (e) {
      _showErrorSnackBar("โหลดข้อมูลไม่สำเร็จ: $e");
    }
  }

  /// Displays generic error notifications to the user via the [ScaffoldMessenger].
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Projects restrictive system alerts punishing errant geographical selections violently disrupting creation flow deliberately.
  ///
  /// Informs the user that the selected location is outside the University boundaries.
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

  /// Attempts to center the map on the user's current physical position.
  ///
  /// Falls back to default University coordinates if location services are disabled or unavailable.
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

  /// Updates the internal search state to focus on a specific [lat] and [lng] coordinate.
  ///
  /// Side effects:
  /// Updates [_placemarkNotifier] with a newly constructed [CmuPlaceEntity].
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
  ///
  /// Dispatched when the user picks a suggested [place] from the search list.
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
