import 'package:avora/core/di/dependecny_injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static SharedPreferences get _prefs =>
      getIt<SharedPreferences>();

  static FlutterSecureStorage get _secureStorage =>
      getIt<FlutterSecureStorage>();

  /// Saves a value in SharedPreferences.
  static Future<void> setData(
    String key,
    Object value,
  ) async {
    debugPrint('Saving preference: $key');

    switch (value) {
      case String():
        await _prefs.setString(key, value);
        break;

      case int():
        await _prefs.setInt(key, value);
        break;

      case bool():
        await _prefs.setBool(key, value);
        break;

      case double():
        await _prefs.setDouble(key, value);
        break;

      case List<String>():
        await _prefs.setStringList(key, value);
        break;

      default:
        throw UnsupportedError(
          'Unsupported type: ${value.runtimeType}',
        );
    }
  }

  static Future<void> removeData(String key) async {
    debugPrint('Removing preference: $key');
    await _prefs.remove(key);
  }

  static Future<void> clearAllData() async {
    debugPrint('Clearing SharedPreferences');
    await _prefs.clear();
  }

  // -------------------------
  // Synchronous getters
  // -------------------------

  static bool getBool(String key) =>
      _prefs.getBool(key) ?? false;

  static int getInt(String key) =>
      _prefs.getInt(key) ?? 0;

  static double getDouble(String key) =>
      _prefs.getDouble(key) ?? 0.0;

  static String? getString(String key) =>
      _prefs.getString(key);

  static List<String> getStringList(String key) =>
      _prefs.getStringList(key) ?? [];

  // -------------------------
  // Secure Storage
  // -------------------------

  static Future<void> setSecuredString(
    String key,
    String value,
  ) async {
    debugPrint('Saving secured value: $key');

    await _secureStorage.write(
      key: key,
      value: value,
    );
  }

  static Future<String> getSecuredString(
    String key,
  ) async {
    debugPrint('Reading secured value: $key');

    return await _secureStorage.read(
          key: key,
        ) ??
        '';
  }

  static Future<void> removeSecuredData(
    String key,
  ) async {
    debugPrint('Removing secured value: $key');

    await _secureStorage.delete(key: key);
  }

  static Future<void> clearAllSecuredData() async {
    debugPrint('Clearing secure storage');

    await _secureStorage.deleteAll();
  }
}