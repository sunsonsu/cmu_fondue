import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState<T extends MapWidget> extends State<T> {
  late GoogleMapController mapController;
  late Future<Position> _userLocationFuture;

  @override
  void initState() {
    super.initState();
    _userLocationFuture = getUserCurrentLocation();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> get markers => {};

  void onCameraMove(CameraPosition position) {}
  void onCameraIdle() {}

  @override
  void dispose() {
    // Check if initialized if necessary, but following original pattern
    try {
      mapController.dispose();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: _userLocationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        LatLng target = LatLng(18.808310458255793, 98.95468245511799);
        if (snapshot.hasData) {
          target = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
        }

        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[200],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: target,
                      zoom: 15.0,
                    ),
                    markers: markers,
                    onCameraMove: onCameraMove,
                    onCameraIdle: onCameraIdle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Position> getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }
}

class MapViewerWidget extends MapWidget {
  const MapViewerWidget({super.key});

  @override
  State<MapViewerWidget> createState() => _MapViewerWidgetState();
}

class _MapViewerWidgetState extends MapWidgetState<MapViewerWidget> {
  final String cmuLogoUrl =
      'https://static.wikia.nocookie.net/garfield/images/5/5e/GarfieldNoBackground.png/revision/latest/scale-to-width/360?cb=20250828223330';
  Uint8List? markerIcon;

  late List<Placemark> placemarks;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Set<Marker> get markers {
    if (markerIcon != null) {
      return {
        Marker(
          markerId: const MarkerId('me'),
          icon: BitmapDescriptor.bytes(markerIcon!),
          position: LatLng(18.808310458255793, 98.95468245511799),
          infoWindow: const InfoWindow(
            title: 'การ์ฟิลด์',
            snippet: 'การ์ฟิลด์นะเนี่ย',
          ),
          onTap: () {
            print("Hello World");
          },
        ),
      };
    }
    return {};
  }

  Future<Uint8List> getBytesFromUrl(String url, int width) async {
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      ui.Codec codec = await ui.instantiateImageCodec(
        response.bodyBytes,
        targetWidth: width,
      );
      ui.FrameInfo fi = await codec.getNextFrame();
      ui.Image image = fi.image;

      // Parameters for the marker shape
      final double borderSize = width * 0.15; // White border thickness
      final double totalRadius = (width / 2) + borderSize;
      final double tailHeight = totalRadius * 0.8;
      final double totalWidth = totalRadius * 2;
      final double totalHeight = totalRadius * 2 + tailHeight;

      final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(pictureRecorder);

      // Define coordinates
      final double cx = totalRadius;
      final double cy = totalRadius;
      final double r = totalRadius;

      Path pinPath = Path();

      final double angleOffset = 35 * math.pi / 180;
      final double startAngle = (math.pi / 2) + angleOffset;

      pinPath.arcTo(
        Rect.fromCircle(center: Offset(cx, cy), radius: r),
        startAngle,
        (2 * math.pi) - (2 * angleOffset),
        false,
      );
      pinPath.lineTo(cx, totalHeight);
      pinPath.close();

      canvas.drawShadow(pinPath, Colors.black.withOpacity(0.5), 5.0, true);

      final Paint whitePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawPath(pinPath, whitePaint);

      final Path imageClipPath = Path()
        ..addOval(
          Rect.fromCircle(center: Offset(cx, cy), radius: width.toDouble() / 2),
        );
      canvas.clipPath(imageClipPath);

      // Draw the image
      canvas.drawImage(
        image,
        Offset(cx - width / 2, cy - width / 2),
        Paint()..isAntiAlias = true,
      );

      final ui.Image compositeImage = await pictureRecorder
          .endRecording()
          .toImage(totalWidth.toInt(), totalHeight.toInt());

      ByteData? result = await compositeImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      return result!.buffer.asUint8List();
    } else {
      throw Exception('Failed to load image from URL');
    }
  }

  Future<void> loadData() async {
    try {
      markerIcon = await getBytesFromUrl(cmuLogoUrl, 50);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error loading marker icon: $e');
    }

    try {
      await setLocaleIdentifier("th_TH");
      placemarks = await placemarkFromCoordinates(
        18.808310458255793,
        98.95468245511799,
      );
      if (mounted) {
        // setState not strictly needed if placemarks are not used in build immediately or if they are just logging
        // But the previous code had it.
        setState(() {});
      }
      if (placemarks.isNotEmpty) {
        print(placemarks[0]);
      }
    } catch (e) {
      debugPrint('Error loading placemarks: $e');
    }
  }
}

class MapSubmitWidget extends MapWidget {
  const MapSubmitWidget({super.key, this.onPlacemarkChanged});

  final ValueChanged<List<Placemark>>? onPlacemarkChanged;

  @override
  State<MapSubmitWidget> createState() => _MapSubmitWidgetState();
}

class _MapSubmitWidgetState extends MapWidgetState<MapSubmitWidget> {
  CameraPosition? userLastPosition;
  @override
  void onCameraMove(CameraPosition position) {
    userLastPosition = position;
  }

  @override
  Future<void> onCameraIdle() async {
    // If user hasn't moved yet, we might want to use the initial center or wait.
    // userLastPosition is null initially.
    final target =
        userLastPosition?.target ??
        LatLng(18.808310458255793, 98.95468245511799);

    List<Placemark> placemarks = [];
    try {
      await setLocaleIdentifier("th_TH");
      placemarks = await placemarkFromCoordinates(
        target.latitude,
        target.longitude,
      );

      if (placemarks.isNotEmpty) {
        widget.onPlacemarkChanged?.call(placemarks);
      }
    } catch (e) {
      debugPrint('Error loading placemarks: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        super.build(context),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35), // Adjust for pin tip
            child: Icon(Icons.location_on, size: 50, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
