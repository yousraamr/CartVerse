import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';

class OrderCubit extends Cubit<List<Order>> {
  OrderCubit() : super([]);

  void placeOrder(List<CartItem> items, double totalPrice) {
    final nextOrderNumber = state.length + 1;

    final order = Order(
      orderNumber: nextOrderNumber.toString(),
      items: List.from(items),
      totalPrice: totalPrice,
      date: DateTime.now(),
    );

    emit([...state, order]);
  }
}
