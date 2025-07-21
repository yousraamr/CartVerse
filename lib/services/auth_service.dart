import 'dart:convert';
import 'dart:io'; //  SocketException
import 'dart:async'; // This gives access to TimeoutException
import 'package:http/http.dart' as http;
import '../utils/cache_helper.dart';

class AuthService {
  final String baseUrl = 'https://cartverse-data.onrender.com';

  // Timeout duration
  final Duration timeoutDuration = const Duration(seconds: 60);

  Future<String> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = data['user']; // user map
        final token = data['accessToken'];

        await CacheHelper.saveString(key: 'firstName', value: user['firstName']);
        await CacheHelper.saveString(key: 'lastName', value: user['lastName']);
        await CacheHelper.saveString(key: 'email', value: user['email']);
        await CacheHelper.saveString(key: 'token', value: token);
        await CacheHelper.saveString(key: 'userId', value: user['id'].toString());

        return user['id'].toString();
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Unexpected login error: $e');
    }
  }


  Future<http.Response> register(String firstName, String lastName, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
        }),
      ).timeout(timeoutDuration);

      return response;
    } on SocketException {
      throw Exception('Network error: Check your internet connection.');
    } on TimeoutException {
      throw Exception('Register request timed out. Server may be sleeping.');
    } catch (e) {
      throw Exception('Unexpected register error: $e');
    }
  }
}
