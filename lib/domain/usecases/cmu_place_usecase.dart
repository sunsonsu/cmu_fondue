/*
 * File: cmu_place_usecase.dart
 * Description: Contains business logic to handle reading and evaluating CMU place locations.
 * Responsibilities: Checks if user locations fall within the campus boundaries and provides place entities.
 * Author: Apiwit 650510648
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';
import 'package:cmu_fondue/domain/repositories/cmu_place_repo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Provides business rules and validation regarding campus locations.
class CmuPlaceUsecase {
  /// The repository dependency for fetching campus places.
  final CmuPlaceRepo repository;

  /// Initializes a new instance of [CmuPlaceUsecase] with the provided [repository].
  CmuPlaceUsecase(this.repository);

  /// The hardcoded center coordinate of the campus based on environment variables.
  final cmuLocation = LatLng(
    double.parse(dotenv.env['CMU_LAT']!),
    double.parse(dotenv.env['CMU_LNG']!),
  );

  /// The radius boundary in meters establishing the campus limit.
  final cmuRadiusInMeters = double.parse(dotenv.env['CMU_RADIUS']!);

  /// Retrieves a comprehensive list of defined locations inside the campus.
  ///
  /// This operates asynchronously and coordinates with the underlying repository.
  Future<List<CmuPlaceEntity>> getCmuPlaces() async {
    return await repository.getCmuPlaces();
  }

  /// Evaluates whether the provided [userLocation] falls within the defined radius of the campus.
  bool isInsideCmu(LatLng userLocation) {
    double distanceInMeters = Geolocator.distanceBetween(
      cmuLocation.latitude,
      cmuLocation.longitude,
      userLocation.latitude,
      userLocation.longitude,
    );
    return distanceInMeters <= cmuRadiusInMeters;
  }
}
