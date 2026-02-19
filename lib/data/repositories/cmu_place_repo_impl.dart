import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';
import 'package:cmu_fondue/domain/repositories/cmu_place_repo.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cmu_fondue/main.dart';

class CmuPlaceRepoImpl implements CmuPlaceRepo {
  @override
  Future<List<CmuPlaceEntity>> getCmuPlaces() async {
    dynamic data;
    final cachedData = cache.get('cmu_places');
    if (cachedData != null) {
      data = cachedData;
    } else {
      data = await fetchFromGoogle();
    }
    final places = data['places'];
    final List<CmuPlaceEntity> cmuPlaces = [];
    for (var place in places) {
      cmuPlaces.add(CmuPlaceEntity.fromGoogleApi(place));
    }

    return cmuPlaces;
  }

  dynamic fetchFromGoogle() async {
    const String googleMapsApikey = String.fromEnvironment('GCP_API_KEY');
    const String url = 'https://places.googleapis.com/v1/places:searchNearby';
    final cmuLat = double.parse(dotenv.env['CMU_LAT']!);
    final cmuLng = double.parse(dotenv.env['CMU_LNG']!);
    final cmuRadius = double.parse(dotenv.env['CMU_RADIUS']!);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': googleMapsApikey,
      'X-Goog-FieldMask':
          'places.displayName,places.formattedAddress,places.location',
    };

    final Map<String, dynamic> body = {
      "includedTypes": [
        "academic_department",
        "educational_institution",
        "library",
        "research_institute",
        "school",
        "university",
        "food_court",
        "museum",
        "convenience_store",
        "park",
        "historical_place",
      ],
      "maxResultCount": 20,
      "languageCode": "th",
      "locationRestriction": {
        "circle": {
          "center": {"latitude": cmuLat, "longitude": cmuLng},
          "radius": cmuRadius,
        },
      },
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode != 200) {
      debugPrint(response.body);
      throw Exception('Failed to fetch CMU places');
    }

    final data = json.decode(response.body);
    await cache.set('cmu_places', data);
    return data;
  }
}
