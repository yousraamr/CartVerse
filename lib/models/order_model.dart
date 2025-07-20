import 'cart_item_model.dart';

class Order {
  final String orderNumber;
  final List<CartItem> items;
  final double totalPrice;
  final DateTime date;

  Order({
    required this.orderNumber,
    required this.items,
    required this.totalPrice,
    required this.date,
  });
}
