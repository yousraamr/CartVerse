import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/cache_helper.dart';
import '../data/mock_products.dart';
import '../models/product_model.dart';

class WishlistService {
  static const String baseUrl = 'https://cartverse-data.onrender.com';

  Future<List<Product>> fetchWishlist() async {
    final userId = CacheHelper.getString(key: 'userId') ?? '';
    final response = await http.get(Uri.parse('$baseUrl/wishlist?userId=$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // Convert to Product list using mock products
      final products = data.map((item) {
        final productId = item['productId'];
        return mockProducts.firstWhere((p) => p.id == productId);
      }).toList();
      return products;
    } else {
      throw Exception('Failed to load wishlist');
    }
  }

  Future<void> addToWishlist(Product product) async {
    final userId = CacheHelper.getString(key: 'userId') ?? '';
    await http.post(
      Uri.parse('$baseUrl/wishlist'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': int.parse(userId),
        'productId': product.id,
      }),
    );
  }

  Future<void> removeFromWishlist(String productId) async {
    // First find the wishlist entry id for this user+product
    final userId = CacheHelper.getString(key: 'userId') ?? '';
    final response = await http.get(Uri.parse('$baseUrl/wishlist?userId=$userId&productId=$productId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final wishlistId = data[0]['id'];
        await http.delete(Uri.parse('$baseUrl/wishlist/$wishlistId'));
      }
    }
  }
}