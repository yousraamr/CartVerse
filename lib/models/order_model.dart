import 'cart_item_model.dart';

class Order {
  final String orderNumber;
  final String userId;
  final List<CartItem> items;
  final double totalPrice;
  final DateTime date;

  Order({
    required this.orderNumber,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "orderNumber": orderNumber,
      "userId": userId,
      "items": items.map((e) => e.toMap()).toList(),
      "totalPrice": totalPrice,
      "date": date.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderNumber: map["orderNumber"],
      userId: map["userId"],
      items: (map["items"] as List)
          .map((e) => CartItem.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      totalPrice: (map["totalPrice"] as num).toDouble(),
      date: DateTime.parse(map["date"]),
    );
  }
}
