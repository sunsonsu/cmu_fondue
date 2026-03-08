/*
 * File: area_problems_map_page.dart
 * Description: Interactive localized map screening isolating problems geometrically.
 * Responsibilities: Draws pinned clusters targeting isolated sectors and constructs scrolling lists synced closely alongside map actions.
 * Dependencies: ProblemProvider, ProblemCard, GoogleMap
 * Lifecycle: Pushed onto Navigator stack by selecting specific map zones, Disposed immediately when user presses back.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/// Renders a specialized spatial viewer bridging listed occurrences directly toward colored map markers contextually.
class AreaProblemsMapPage extends StatefulWidget {
  /// The human-readable regional designation shown within the top app bar.
  final String areaName;
  
  /// The constrained selection of issues isolated purely to this locale.
  final List<ProblemEntity> problems;

  /// Initializes a new instance of [AreaProblemsMapPage].
  const AreaProblemsMapPage({
    super.key,
    required this.areaName,
    required this.problems,
  });

  @override
  State<AreaProblemsMapPage> createState() => _AreaProblemsMapPageState();
}

class _AreaProblemsMapPageState extends State<AreaProblemsMapPage> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  LatLng? _center;

  @override
  void initState() {
    super.initState();
    _setupMarkers();
  }

  /// Calculates geometric center-points and generates visual mapping nodes dynamically.
  ///
  /// Side effects:
  /// Rewrites the [_markers] arrays and the [_center] camera origin directly.
  void _setupMarkers() {
    if (widget.problems.isEmpty) return;

    double totalLat = 0;
    double totalLng = 0;
    for (var problem in widget.problems) {
      totalLat += problem.lat;
      totalLng += problem.lng;
    }
    _center = LatLng(
      totalLat / widget.problems.length,
      totalLng / widget.problems.length,
    );

    _markers = widget.problems.map((problem) {
      return Marker(
        markerId: MarkerId(problem.id),
        position: LatLng(problem.lat, problem.lng),
        infoWindow: InfoWindow(
          title: problem.title,
          snippet: problem.locationName,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          _getMarkerColor(problem.tagName.name),
        ),
      );
    }).toSet();
  }

  /// Determines strictly which pigment represents a specific operational phase.
  ///
  /// Formally enforces red for un-ticketed issues, orange for active repairs, and green signaling closed resolutions. 
  double _getMarkerColor(String tagName) {
    switch (tagName) {
      case 'pending':
        return BitmapDescriptor.hueRed;
      case 'inProgress':
        return BitmapDescriptor.hueOrange;
      case 'completed':
        return BitmapDescriptor.hueGreen;
      default:
        return BitmapDescriptor.hueRed;
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5D3891)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.areaName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D3891),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _center == null
                    ? const Center(child: CircularProgressIndicator())
                    : GoogleMap(
                        onMapCreated: (controller) =>
                            _mapController = controller,
                        initialCameraPosition: CameraPosition(
                          target: _center!,
                          zoom: 15,
                        ),
                        markers: _markers,
                        zoomControlsEnabled: true,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                      ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('รอดำเนินการ', Colors.red),
                const SizedBox(width: 16),
                _buildLegendItem('ดำเนินการอยู่', Colors.orange),
                const SizedBox(width: 16),
                _buildLegendItem('เสร็จสิ้น', Colors.green),
              ],
            ),
          ),

          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.list_alt, color: Color(0xFF5D3891)),
                        const SizedBox(width: 8),
                        Text(
                          'ปัญหาในพื้นที่นี้ (${widget.problems.length})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D3891),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: widget.problems.isEmpty
                        ? const Center(
                            child: Text(
                              'ไม่พบข้อมูล',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: widget.problems.length,
                            itemBuilder: (context, index) {
                              return ProblemCard(
                                key: ValueKey(widget.problems[index].id),
                                problem: widget.problems[index],
                                onDeleted: () {
                                  setState(() {
                                    widget.problems.removeAt(index);
                                    _setupMarkers();
                                  });
                                },
                                onUpvote: (isUpvoted) => context
                                    .read<ProblemProvider>()
                                    .toggleUpvote(
                                      problemId: widget.problems[index].id,
                                      isUpvoted: isUpvoted,
                                    ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Constructs a horizontal legend indicator translating internal mapping colors towards user-friendly tags.
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
