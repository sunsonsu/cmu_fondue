import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static const _boxName = 'cmu_places_cache';
  static const _defaultTtl = 7;
  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  Future<void> set(String key, dynamic value, {int ttl = _defaultTtl}) async {
    await _box.put(key, {
      'data': json.encode(value),
      'expiry': DateTime.now().add(Duration(days: ttl)).toIso8601String(),
    });
  }

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
