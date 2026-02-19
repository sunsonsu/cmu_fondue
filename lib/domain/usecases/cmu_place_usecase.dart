import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';
import 'package:cmu_fondue/domain/repositories/cmu_place_repo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CmuPlaceUsecase {
  final CmuPlaceRepo repository;

  CmuPlaceUsecase(this.repository);

  final cmuLocation = LatLng(
    double.parse(dotenv.env['CMU_LAT']!),
    double.parse(dotenv.env['CMU_LNG']!),
  );

  final cmuRadiusInMeters = double.parse(dotenv.env['CMU_RADIUS']!);

  Future<List<CmuPlaceEntity>> getCmuPlaces() async {
    return await repository.getCmuPlaces();
  }

  bool isInsideCmu(LatLng userLocation) {
    double distanceInMeters = Geolocator.distanceBetween(
      cmuLocation.latitude,
      cmuLocation.longitude,
      userLocation.latitude,
      userLocation.longitude,
    );
    print('Distance in meters: $distanceInMeters');
    print('CMU radius in meters: $cmuRadiusInMeters');
    print('Is inside CMU: ${distanceInMeters <= cmuRadiusInMeters}');
    return distanceInMeters <= cmuRadiusInMeters;
  }
}
