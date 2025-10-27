import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum CacheFrequency { none, oneHour, sixHours, oneDay, oneWeek }

class SharedPrefsService {
  static Future<void> set(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value.toString());
  }

  static Future<String?> get(String key, {String Function()? onNull}) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    return value ?? (onNull != null ? onNull() : null);
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Duration _frequencyToDuration(CacheFrequency frequency) {
    switch (frequency) {
      case CacheFrequency.none:
        return Duration(seconds: 0);
      case CacheFrequency.oneHour:
        return Duration(hours: 1);
      case CacheFrequency.sixHours:
        return Duration(hours: 6);
      case CacheFrequency.oneDay:
        return Duration(days: 1);
      case CacheFrequency.oneWeek:
        return Duration(days: 7);
    }
  }

  Future<http.Response> cacheResponse({
    required String key,
    required CacheFrequency frequency,
    required Future<http.Response> Function() fetchCallback,
    bool override = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final cachedData = prefs.getString(key);
    final cachedTimestampStr = prefs.getString('${key}_timestamp');
    final now = DateTime.now();

    // Check if the cache is present
    bool cacheExist = cachedData != null && cachedTimestampStr != null;
    if (!override && cacheExist) {
      final cachedTimestamp = DateTime.tryParse(cachedTimestampStr);
      if (cachedTimestamp != null) {
        final expiryDuration = _frequencyToDuration(frequency);
        if (now.difference(cachedTimestamp) < expiryDuration) {
          return http.Response(cachedData, 200);
        } else {
          // Cache expired, clear cached data and timestamp
          await prefs.remove(key);
          await prefs.remove('${key}_timestamp');
        }
      } else {
        // Invalid timestamp, clear cache
        await prefs.remove(key);
        await prefs.remove('${key}_timestamp');
      }
    }

    // Cache missing or expired, call callback to fetch fresh data
    final response = await fetchCallback();

    // Save response body and timestamp to prefs
    if (response.statusCode == 200 || response.statusCode == 201) {
      await prefs.setString(key, response.body);
      await prefs.setString('${key}_timestamp', now.toIso8601String());
    }

    return response;
  }
}
