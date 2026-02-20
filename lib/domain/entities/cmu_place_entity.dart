import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CmuPlaceEntity {
  final String name;
  final double lat;
  final double lng;
  final String formattedAddress;

  CmuPlaceEntity({
    required this.name,
    required this.lat,
    required this.lng,
    required this.formattedAddress,
  });

  factory CmuPlaceEntity.fromGoogleApi(dynamic apiData) {
    return CmuPlaceEntity(
      name: apiData["displayName"]?["text"] ?? "",
      lat: apiData["location"]?["latitude"] ?? 0.0,
      lng: apiData["location"]?["longitude"] ?? 0.0,
      formattedAddress: apiData["formattedAddress"] ?? "",
    );
  }

  factory CmuPlaceEntity.fromPlacemark(Placemark placemark, LatLng latLng) {
    return CmuPlaceEntity(
      name: placemark.name ?? "Unknown",
      lat: latLng.latitude,
      lng: latLng.longitude,
      formattedAddress:
          "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.country}",
    );
  }
}
