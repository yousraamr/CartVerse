import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  // Initialize
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save string
  static Future<bool> saveString({required String key, required String value}) async {
    return await _prefs!.setString(key, value);
  }

  // Save boolean
  static Future<bool> saveBool({required String key, required bool value}) async {
    return await _prefs!.setBool(key, value);
  }

  // Get string
  static String? getString({required String key}) {
    return _prefs!.getString(key);
  }

  // Get boolean
  static bool? getBool({required String key}) {
    return _prefs!.getBool(key);
  }

  // Remove
  static Future<bool> removeData({required String key}) async {
    return await _prefs!.remove(key);
  }

  // Clear all
  static Future<bool> clearAll() async {
    return await _prefs!.clear();
  }
}
