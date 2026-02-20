import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProblemLocationMap extends StatefulWidget {
  final LatLng location;
  final String title;
  final String snippet;

  const ProblemLocationMap({
    super.key,
    required this.location,
    required this.title,
    required this.snippet,
  });

  @override
  State<ProblemLocationMap> createState() => _ProblemLocationMapState();
}

class _ProblemLocationMapState extends State<ProblemLocationMap> {
  GoogleMapController? _mapController;

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // พิกัด
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.place,
                size: 16,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Kanit',
                    ),
                    children: [
                      TextSpan(
                        text: 'พิกัด: ',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      TextSpan(
                        text: '${widget.location.latitude.toStringAsFixed(6)}, ${widget.location.longitude.toStringAsFixed(6)}',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Google Map
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 250,
            child: GoogleMap(
              onMapCreated: (controller) => _mapController = controller,
              initialCameraPosition: CameraPosition(
                target: widget.location,
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('problem_location'),
                  position: widget.location,
                  infoWindow: InfoWindow(
                    title: widget.title,
                    snippet: widget.snippet,
                  ),
                ),
              },
              zoomControlsEnabled: true,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
            ),
          ),
        ),
      ],
    );
  }
}
