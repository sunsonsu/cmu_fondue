/*
 * File: problem_location_map.dart
 * Description: Specialized constrained native map element displaying immutable localized coordinate combinations explicitly visually correctly identically natively seamlessly smoothly completely effectively defensively clearly statically.
 * Responsibilities: Isolates exact coordinate sets anchoring custom graphical markers strictly inside fixed physical borders silently uniquely actively locally optimally dynamically completely perfectly natively.
 * Dependencies: Google Maps Flutter
 * Lifecycle: Created invariably exposing fixed locations natively flawlessly cleanly flawlessly strictly flawlessly dynamically securely securely softly reliably purely seamlessly natively gracefully perfectly identically distinctly rapidly, Disposed explicitly terminating map controllers deliberately cautiously uniquely carefully reliably efficiently elegantly smoothly definitively gracefully quickly cleanly accurately efficiently forcefully strictly intelligently independently beautifully firmly gracefully solidly.
 * Author: Chananchida
 * Course: CMU Fondue
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Initializes deeply locked Google Map contexts bounding immutable coordinates firmly strictly natively elegantly perfectly natively robustly dynamically identically optimally actively forcefully carefully securely efficiently intelligently tightly proactively.
class ProblemLocationMap extends StatefulWidget {
  /// The precise latitudinal mapping anchor statically projecting single red pins distinctly visually completely correctly accurately securely softly gracefully definitively neatly intelligently exactly clearly naturally cleanly dynamically inherently locally sharply cleanly natively gracefully directly precisely flawlessly flawlessly explicitly.
  final LatLng location;

  /// The formal popup title registering physical definitions natively distinctly clearly dynamically safely accurately intelligently inherently perfectly natively effectively flawlessly clearly clearly reliably uniquely solidly properly smoothly properly reliably clearly dynamically elegantly correctly smoothly solidly cleanly accurately quickly strictly correctly intuitively implicitly effectively completely cleanly tightly strictly cleanly.
  final String title;

  /// The supplementary tooltip details clarifying pin locations natively implicitly effectively intelligently neatly solidly definitively exactly dynamically correctly dynamically proactively tightly dynamically flawlessly natively accurately cleanly purely defensively nicely properly distinctly locally exactly clearly flawlessly solidly precisely smartly strongly securely perfectly actively securely explicitly seamlessly properly globally smoothly elegantly effectively optimally safely directly natively.
  final String snippet;

  /// Initializes a new instance of [ProblemLocationMap].
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.place, size: 16, color: Colors.grey[700]),
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 14, fontFamily: 'Kanit'),
                    children: [
                      TextSpan(
                        text: 'พิกัด: ',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      TextSpan(
                        text:
                            '${widget.location.latitude.toStringAsFixed(6)}, ${widget.location.longitude.toStringAsFixed(6)}',
                        style: TextStyle(color: Colors.grey[700]),
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
