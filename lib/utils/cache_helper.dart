import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  // Initialize
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save string
  static Future<bool> saveData({required String key, required String value}) async {
    return await _prefs!.setString(key, value);
  }

  // Get string
  static String? getData({required String key}) {
    return _prefs!.getString(key);
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
