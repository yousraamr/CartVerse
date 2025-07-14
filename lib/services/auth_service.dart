import 'dart:convert';
import 'dart:io'; // For SocketException
import 'dart:async'; // This gives access to TimeoutException
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://cartverse-data.onrender.com';

  // Timeout duration
  final Duration timeoutDuration = const Duration(seconds: 60);

  Future<http.Response> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(timeoutDuration);

      return response;
    } on SocketException {
      throw Exception('Network error: Check your internet connection.');
    } on TimeoutException {
      throw Exception('Login request timed out. Server may be sleeping.');
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
