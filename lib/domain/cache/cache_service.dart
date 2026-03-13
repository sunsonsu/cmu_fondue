/*
 * File: cache_service.dart
 * Description: Service for handling local data caching using Hive.
 * Responsibilities: Initializes the Hive box, stores, retrieves, and expires cached data.
 * Author: Apiwit 650510648
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

/// A service to easily cache values over a time-to-live period.
///
/// This uses Hive underneath to store key-value pairs which contain an expiry date.
class CacheService {
  static const _boxName = 'cmu_places_cache';
  static const _defaultTtl = 7;
  late Box _box;

  /// Initializes the local Hive database and opens the cache box.
  ///
  /// This must be called before any data can be stored or retrieved.
  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  /// Sets a value in the cache with the specified key and time-to-live.
  ///
  /// The [value] gets json-encoded before being stored. The [ttl] defaults to
  /// 7 days if not provided.
  Future<void> set(String key, dynamic value, {int ttl = _defaultTtl}) async {
    await _box.put(key, {
      'data': json.encode(value),
      'expiry': DateTime.now().add(Duration(days: ttl)).toIso8601String(),
    });
  }

  /// Retrieves a value from the cache given its [key].
  ///
  /// If the entry does not exist or has expired, it returns null. Expired
  /// entries are removed from the cache upon retrieval attempt.
  dynamic get(String key) {
    final entry = _box.get(key);
    if (entry == null) return null;
    if (DateTime.now().isAfter(DateTime.parse(entry['expiry']))) {
      _box.delete(key);
      return null;
    }
    return json.decode(entry['data']);
  }
}
