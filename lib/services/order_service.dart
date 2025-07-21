import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/cache_helper.dart';
import '../models/order_model.dart';

class OrderService {
  static const String baseUrl = 'https://cartverse-data.onrender.com';

  Future<List<Order>> fetchOrders() async {
    final userId = CacheHelper.getString(key: 'userId') ?? '';
    final response = await http.get(Uri.parse('$baseUrl/orders?userId=$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((orderMap) => Order.fromMap(orderMap)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> placeOrder(Map<String, dynamic> orderPayload) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(orderPayload),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to place order: ${response.body}');
    }
  }
}
