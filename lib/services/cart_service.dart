import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../utils/cache_helper.dart';

class CartService {
  final String baseUrl = 'https://cartverse-data.onrender.com';
  final Duration timeoutDuration = const Duration(seconds: 30);

  Future<List<CartItem>> fetchCart() async {
    final userId = CacheHelper.getString(key: 'userId');
    if (userId == null) return [];

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cart?userId=$userId'),
      ).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => CartItem.fromMap(e)).toList();
      } else {
        throw Exception('Failed to fetch cart: ${response.body}');
      }
    } on SocketException {
      throw Exception('Network error');
    } on TimeoutException {
      throw Exception('Timeout');
    }
  }

  Future<void> addToCart(Product product) async {
    final userId = CacheHelper.getString(key: 'userId');
    if (userId == null) return;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'product': product.toMap(),
          'quantity': 1,
        }),
      ).timeout(timeoutDuration);

      if (response.statusCode != 201) {
        throw Exception('Failed to add to cart: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cart/$cartItemId'),
      ).timeout(timeoutDuration);

      if (response.statusCode != 200) {
        throw Exception('Failed to remove item');
      }
    } catch (e) {
      throw Exception('Error removing item: $e');
    }
  }

  Future<void> updateQuantity(int cartItemId, int quantity) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/cart/$cartItemId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'quantity': quantity}),
      ).timeout(timeoutDuration);

      if (response.statusCode != 200) {
        throw Exception('Failed to update quantity');
      }
    } catch (e) {
      throw Exception('Error updating quantity: $e');
    }
  }
}
