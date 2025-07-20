import 'package:shared_preferences/shared_preferences.dart';
import '../utils/cache_helper.dart';

class UserSession {

  static Future<void> saveUser({
    required String firstName,
    required String lastName,
    required String token,
  }) async {
    await CacheHelper.saveUser(firstName: firstName, lastName: lastName, token: token);
  }

  static Future<Map<String, String?>> getUser() async {
    return await CacheHelper.getUser();
  }

  static Future<void> clearUser() async {
    await CacheHelper.clearUser();
  }
}