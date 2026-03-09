/*
 * File: map_widget.dart
 * Description: Sophisticated native mapping facade integrating raw system geolocation alongside dynamic cloud data markers smoothly seamlessly.
 * Responsibilities: Orchestrates Google Map camera bindings, queries localized hardware sensors securely, draws intricate custom raster graphics natively explicitly overlaying map instances cleanly.
 * Dependencies: ProblemProvider, Google Maps Flutter, Geolocator, Geocoding
 * Lifecycle: Created invariably anchoring core map screens deeply, Disposed cautiously yielding hardware sensors back natively cleanly correctly.
 * Author: Apiwit
 * Course: CMU Fondue
 */

import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:cmu_fondue/application/pages/problem_detail.dart';
import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/data/repositories/cmu_place_repo_impl.dart';
import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/usecases/cmu_place_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

/// Hijacks local device hardware exposing absolute physical coordinates verifying user intent securely defensively loudly globally natively.
///
/// This operates asynchronously demanding formal explicit queries hooking local operating systems distinctly isolating failures gracefully.
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

  try {
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(timeLimit: Duration(seconds: 5)),
    );
  } catch (e) {
    // If it times out or fails (often happens on first install after accepting location),
    // we try to gracefully get the last known position.
    try {
      final position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        return position;
      }
    } catch (_) {}
    return Future.error('Failed to get location: $e');
  }
}

/// Abstract generic anchoring map layers strictly constraining global padding and common initialization logic cohesively natively seamlessly.
class MapWidget extends StatefulWidget {
  /// The fixed padding shielding map UI controls beneath overlapping floating view components intelligently cleanly natively.
  final EdgeInsets mapPadding;

  /// The message to display when the user is located outside CMU.
  final String outsideCmuMessage;

  /// Whether to suppress the initial notification snackbar on instantiation.
  final bool disableInitialSnackbar;

  /// Initializes a new instance of [MapWidget].
  const MapWidget({
    super.key,
    this.mapPadding = EdgeInsets.zero,
    this.outsideCmuMessage =
        'คุณอยู่นอกเขตมหาวิทยาลัยเชียงใหม่ ระบบจะแสดงแผนที่บริเวณ มช.',
    this.disableInitialSnackbar = false,
  });

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState<T extends MapWidget> extends State<T> {
  /// The mutable underlying host controller manipulating native map properties instantly efficiently correctly globally.
  late GoogleMapController mapController;
  late Future<Position> _userLocationFuture;
  bool _hasNotifiedOutsideCmu = false;

  @override
  void initState() {
    super.initState();
    _userLocationFuture = getUserCurrentLocation();
  }

  /// Injects active map engine instances completely explicitly binding local controls dynamically natively seamlessly flawlessly locally.
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  /// Overridable property returning dynamic graphics arrays populating canvas spaces dynamically distinctly locally.
  Set<Marker> get markers => {};

  /// Captures arbitrary manual panning gestures catching camera transitions actively reliably inherently globally.
  void onCameraMove(CameraPosition position) {}

  /// Catches terminal camera movements actively firing background logic efficiently reliably transparently locally natively.
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

        LatLng target = const LatLng(18.808310458255793, 98.95468245511799);
        if (snapshot.hasData) {
          final userLocation = LatLng(
            snapshot.data!.latitude,
            snapshot.data!.longitude,
          );
          final cmuPlaceUsecase = CmuPlaceUsecase(CmuPlaceRepoImpl());

          if (cmuPlaceUsecase.isInsideCmu(userLocation)) {
            target = userLocation;
          } else {
            if (!_hasNotifiedOutsideCmu && !widget.disableInitialSnackbar) {
              _hasNotifiedOutsideCmu = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('แจ้งเตือน'),
                      content: Text(widget.outsideCmuMessage),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('ตกลง'),
                        ),
                      ],
                    ),
                  );
                }
              });
            }
          }
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
}

/// Specialized implementation binding global cloud datasets actively projecting dynamic graphic clusters atop generic maps flawlessly directly dynamically.
class MapViewerWidget extends MapWidget {
  /// Initializes a new instance of [MapViewerWidget].
  const MapViewerWidget({super.key})
    : super(
        outsideCmuMessage:
            'คุณไม่ได้อยู่ในพื้นที่ มช. จะสามารถดูปัญหาได้เพียงอย่างเดียว',
      );

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
    ).notCompletedProblems;

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

  /// Downloads raw byte arrays actively reshaping imagery dynamically parsing raw binary buffers painting intricate graphical markers natively efficiently.
  ///
  /// This operates asynchronously initiating deep architecture queries securely hooking local operating systems distinctly isolating failures gracefully.
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

  /// Bulk loads graphical markers traversing active problem subsets cleanly firing independent async downloads locally completely securely natively.
  ///
  /// Side effects:
  /// Violently replaces mapping icons within [_markerIcons] triggering native [setState] entirely gracefully cleanly loudly securely dynamically distinctly.
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

  /// Bootstraps complete domain datasets pulling raw objects mapping everything actively initially correctly natively.
  ///
  /// This operates asynchronously demanding formal explicit queries hooking local operating systems distinctly isolating failures gracefully.
  Future<void> loadData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ProblemProvider>(context, listen: false);
      await provider.fetchProblems();
      await _loadMarkerIcons(provider.notCompletedProblems);
    });
  }
}

/// Specialized implementation centering explicit cursor pins translating continuous scrolling into validated logical entities cleanly explicitly natively.
class MapSubmitWidget extends MapWidget {
  /// Casts arbitrary entity arrays backwards feeding form creation explicitly securely uniquely locally proactively natively.
  final ValueChanged<List<CmuPlaceEntity>>? onPlacemarkChanged;

  /// The specific external entity forcing programmatic camera snaps natively quickly deliberately distinctly consistently directly.
  final CmuPlaceEntity? selectedPlace;

  /// Initializes a new instance of [MapSubmitWidget].
  const MapSubmitWidget({
    super.key,
    this.onPlacemarkChanged,
    this.selectedPlace,
  }) : super(
         mapPadding: const EdgeInsets.only(top: 80, bottom: 200),
         disableInitialSnackbar: true,
       );

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

  /// Forces internal Google Map drivers moving actively focusing targeted domains programmatically dynamically instantly perfectly cleanly loudly natively.
  ///
  /// This operates asynchronously requesting deep mobile sensor queries distinctly elegantly actively completely gracefully strictly distinct globally natively explicitly.
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
        final userLocation = LatLng(position.latitude, position.longitude);
        final cmuPlaceUsecase = CmuPlaceUsecase(CmuPlaceRepoImpl());
        if (cmuPlaceUsecase.isInsideCmu(userLocation)) {
          target = userLocation;
        } else {
          target = const LatLng(18.808310458255793, 98.95468245511799);
        }
      } catch (e) {
        target = const LatLng(18.808310458255793, 98.95468245511799);
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
