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

  static Future<void> saveUser({
    required String firstName,
    required String lastName,
    required String email,
    required String token,
  }) async {
    await _prefs!.setString('firstName', firstName);
    await _prefs!.setString('lastName', lastName);
    await _prefs!.setString('email', email);
    await _prefs!.setString('token', token);
  }

  static Future<Map<String, String?>> getUser() async {
    return {
      'firstName': _prefs!.getString('firstName'),
      'lastName': _prefs!.getString('lastName'),
      'email': _prefs!.getString('email'),
      'token': _prefs!.getString('token'),
    };
  }

  static Future<void> clearUser() async {
    await _prefs!.remove('firstName');
    await _prefs!.remove('lastName');
    await _prefs!.remove('token');
  }
}
