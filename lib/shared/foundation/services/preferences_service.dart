import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../supplements/constants/shared_prefs_keys.dart';

class PreferencesService {
  final SharedPreferences prefs;

  PreferencesService({required this.prefs});

  Future<void> get clear async => await prefs.clear();

  Future<void> persistLocale(String value) =>
      _saveToDisk(sharedPrefKeys.locale, value);
  String get locale => prefs.getString(sharedPrefKeys.locale) ?? 'az';

  Future<void> clearAllData() => prefs.clear();

  Future<void> _saveToDisk<T>(String key, T value) async {
    debugPrint('--> {PreferencesService}: key: $key, value: $value');
    if (value is String) await prefs.setString(key, value);
    if (value is bool) await prefs.setBool(key, value);
    if (value is int) await prefs.setInt(key, value);
    if (value is double) await prefs.setDouble(key, value);
    if (value is List<String>) await prefs.setStringList(key, value);
  }
}
