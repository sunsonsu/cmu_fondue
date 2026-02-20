import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:cmu_fondue/application/pages/problem_detail.dart';
import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key, this.mapPadding = EdgeInsets.zero});

  final EdgeInsets mapPadding;

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
                    padding: widget.mapPadding,
                    onMapCreated: onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: target,
                      zoom: 15.0,
                    ),
                    markers: markers,
                    onCameraMove: onCameraMove,
                    onCameraIdle: onCameraIdle,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
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
  final Map<String, Uint8List> _markerIcons = {};

  late List<Placemark> placemarks;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Set<Marker> get markers {
    final problems = Provider.of<ProblemProvider>(
      context,
      listen: false,
    ).problems;

    return problems.map((ProblemEntity problem) {
      final Uint8List? icon = _markerIcons[problem.id];
      return Marker(
        markerId: MarkerId(problem.id),
        icon: icon != null
            ? BitmapDescriptor.bytes(icon)
            : BitmapDescriptor.defaultMarker,
        position: LatLng(problem.lat, problem.lng),
        infoWindow: InfoWindow(
          title: problem.title,
          snippet: problem.locationName,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProblemDetailPage(problem: problem),
            ),
          );
        },
      );
    }).toSet();
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

  Future<void> _loadMarkerIcons(List<ProblemEntity> problems) async {
    for (final problem in problems) {
      if (problem.imageUrl != null && problem.imageUrl!.isNotEmpty) {
        try {
          final iconBytes = await getBytesFromUrl(problem.imageUrl!, 50);
          _markerIcons[problem.id] = iconBytes;
        } catch (e) {
          debugPrint('Error loading marker icon for ${problem.id}: $e');
        }
      }
    }
    if (mounted) setState(() {});
  }

  Future<void> loadData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ProblemProvider>(context, listen: false);
      await provider.fetchNotCompletedProblems();
      await _loadMarkerIcons(provider.problems);
    });
  }
}

class MapSubmitWidget extends MapWidget {
  const MapSubmitWidget({
    super.key,
    this.onPlacemarkChanged,
    this.selectedPlace,
  }) : super(mapPadding: const EdgeInsets.only(top: 80, bottom: 200));

  final ValueChanged<List<CmuPlaceEntity>>? onPlacemarkChanged;
  final CmuPlaceEntity? selectedPlace;

  @override
  State<MapSubmitWidget> createState() => _MapSubmitWidgetState();
}

class _MapSubmitWidgetState extends MapWidgetState<MapSubmitWidget> {
  CameraPosition? userLastPosition;

  @override
  void didUpdateWidget(MapSubmitWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedPlace != null &&
        widget.selectedPlace != oldWidget.selectedPlace) {
      _animateToSelectedPlace();
    }
  }

  Future<void> _animateToSelectedPlace() async {
    try {
      await mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              widget.selectedPlace!.lat,
              widget.selectedPlace!.lng,
            ),
            zoom: 18.0,
          ),
        ),
      );
    } catch (e) {
      debugPrint("Error moving camera: $e");
    }
  }

  @override
  void onCameraMove(CameraPosition position) {
    userLastPosition = position;
  }

  @override
  Future<void> onCameraIdle() async {
    LatLng target;
    if (userLastPosition != null) {
      target = userLastPosition!.target;
    } else {
      try {
        final position = await _userLocationFuture;
        target = LatLng(position.latitude, position.longitude);
      } catch (e) {
        target = LatLng(18.808310458255793, 98.95468245511799);
      }
    }

    List<Placemark> placemarks = [];
    List<CmuPlaceEntity> cmuPlaces = [];
    try {
      await setLocaleIdentifier("th_TH");
      placemarks = await placemarkFromCoordinates(
        target.latitude,
        target.longitude,
      );
      if (placemarks.isNotEmpty) {
        for (var placemark in placemarks) {
          cmuPlaces.add(CmuPlaceEntity.fromPlacemark(placemark, target));
        }
        placemarks.clear();
        widget.onPlacemarkChanged?.call(cmuPlaces);
      }
    } catch (e) {
      debugPrint('Error loading placemarks: $e');
    }
  }

  @override
  void onMapCreated(GoogleMapController controller) {
    super.onMapCreated(controller);
    // เลื่อน camera ขึ้นหลัง map โหลดเสร็จ
    Future.delayed(const Duration(milliseconds: 300), () {
      controller.animateCamera(
        CameraUpdate.scrollBy(0, 60), // (bottom_padding - top_padding) / 2
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = widget.mapPadding.bottom; // 200
    return Stack(
      children: [
        super.build(context),
        Positioned.fill(
          top: widget.mapPadding.top,
          bottom: bottomPadding,
          child: Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: const Offset(0, -25),
              child: const Icon(Icons.location_on, size: 50, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
