import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';
import '../utils/cache_helper.dart';
import '../services/order_service.dart';

class OrderCubit extends Cubit<List<Order>> {
  final OrderService orderService;

  OrderCubit(this.orderService) : super([]);

  Future<void> fetchOrders() async {
    try {
      final orders = await orderService.fetchOrders();
      emit(orders);
    } catch (e) {
      emit([]);
    }
  }

  Future<void> placeOrder({
    required List<CartItem> items,
    required double totalPrice,
  }) async {
    final userId = CacheHelper.getString(key: 'userId') ?? '';

    int nextOrderNumber = 1;
    if (state.isNotEmpty) {
      final lastOrder = state.last;
      nextOrderNumber = int.tryParse(lastOrder.orderNumber) != null
          ? int.parse(lastOrder.orderNumber) + 1
          : state.length + 1;
    }

    final orderPayload = {
      "userId": userId,
      "orderNumber": nextOrderNumber.toString(),
      "items": items.map((item) {
        return {
          "productId": item.product.id,
          "name": item.product.name,
          "price": item.product.price,
          "quantity": item.quantity,
        };
      }).toList(),
      "totalPrice": totalPrice,
      "date": DateTime.now().toIso8601String(),
    };

    try {
      await orderService.placeOrder(orderPayload);
      final newOrder = Order(
        orderNumber: nextOrderNumber.toString(),
        userId: userId,
        items: items,
        totalPrice: totalPrice,
        date: DateTime.now(),
      );
      emit([...state, newOrder]);
    } catch (e) {
      print("Error placing order: $e");
    }
  }

  void clearOrders() => emit([]);
}
