/*
 * File: cmu_place_entity.dart
 * Description: Entity representing a location or place within the CMU Fondue system.
 * Responsibilities: Holds data for a place, including its coordinates and address, and provides factories for parsing from API or placemark data.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Describes a physical place that can be identified via coordinates.
class CmuPlaceEntity {
  /// The name of the place.
  final String name;

  /// The latitude coordinate of the place.
  final double lat;

  /// The longitude coordinate of the place.
  final double lng;

  /// The formatted address corresponding to the place.
  final String formattedAddress;

  /// Initializes a new instance of [CmuPlaceEntity].
  CmuPlaceEntity({
    required this.name,
    required this.lat,
    required this.lng,
    required this.formattedAddress,
  });

  /// Constructs an entity from dynamic Google API data.
  factory CmuPlaceEntity.fromGoogleApi(dynamic apiData) {
    return CmuPlaceEntity(
      name: apiData["displayName"]?["text"] ?? "",
      lat: apiData["location"]?["latitude"] ?? 0.0,
      lng: apiData["location"]?["longitude"] ?? 0.0,
      formattedAddress: apiData["formattedAddress"] ?? "",
    );
  }

  /// Constructs an entity given a Geocoding [Placemark] and specific coordinates.
  factory CmuPlaceEntity.fromPlacemark(Placemark placemark, LatLng latLng) {
    return CmuPlaceEntity(
      name: placemark.name ?? "Unknown",
      lat: latLng.latitude,
      lng: latLng.longitude,
      formattedAddress: [
        placemark.street,
        placemark.subLocality,
        placemark.locality,
        placemark.country,
      ].where((s) => s != null && s.isNotEmpty).join(", "),
    );
  }
}
