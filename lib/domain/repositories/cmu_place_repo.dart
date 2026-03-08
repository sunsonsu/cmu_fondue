/*
 * File: cmu_place_repo.dart
 * Description: Abstract repository interface for retrieving predefined CMU places.
 * Responsibilities: Declares the contract for accessing locations inside the university campus.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';

/// The contract for retrieving mapped locations within the CMU campus.
abstract class CmuPlaceRepo {
  /// Retrieves a comprehensive list of mapped places inside CMU.
  ///
  /// This operates asynchronously. Throws an exception if data cannot be fetched.
  Future<List<CmuPlaceEntity>> getCmuPlaces();
}
