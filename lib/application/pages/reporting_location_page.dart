import 'package:cmu_fondue/application/widgets/map_widget.dart';
import 'package:cmu_fondue/application/widgets/submit_location_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportingLocationPage extends StatefulWidget {
  const ReportingLocationPage({super.key});

  @override
  State<ReportingLocationPage> createState() => _ReportingLocationPageState();
}

class _ReportingLocationPageState extends State<ReportingLocationPage> {
  final ValueNotifier<List<Placemark>?> _placemarkNotifier = ValueNotifier(
    null,
  );

  @override
  void dispose() {
    _placemarkNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapSubmitWidget(
          center: const LatLng(18.808310458255793, 98.95468245511799),
          onPlacemarkChanged: (placemark) =>
              _placemarkNotifier.value = placemark,
        ),
        SubmitLocationBottomSheet(locationNotifier: _placemarkNotifier),
      ],
    );
  }
}
