import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../utils/cache_helper.dart';

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  static const String cartKey = 'cart';

  /// Load cart items from local storage
  void loadCart() {
    final data = CacheHelper.getString(key: cartKey);
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      emit(jsonList.map((e) => CartItem.fromMap(Map<String, dynamic>.from(e))).toList());
    }
  }

  /// Add product to cart, or increase its quantity if it exists
  void addToCart(Product product) {
    final updatedList = List<CartItem>.from(state);
    final index = updatedList.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      updatedList[index].quantity++;
    } else {
      updatedList.add(CartItem(product: product));
    }

    emit(updatedList);
    _saveCart(updatedList);
  }

  /// Remove product completely from cart
  void removeFromCart(Product product) {
    final updatedList = List<CartItem>.from(state)..removeWhere((item) => item.product.id == product.id);
    emit(updatedList);
    _saveCart(updatedList);
  }

  /// Update quantity of a product
  void updateQuantity(Product product, int quantity) {
    final updatedList = List<CartItem>.from(state);
    final index = updatedList.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      updatedList[index].quantity = quantity;
      emit(updatedList);
      _saveCart(updatedList);
    }
  }

  /// Clear the entire cart
  void clearCart() {
    emit([]);
    _saveCart([]);
  }

  /// Save cart state to local storage
  void _saveCart(List<CartItem> cart) {
    final jsonString = jsonEncode(cart.map((e) => e.toMap()).toList());
    CacheHelper.saveString(key: cartKey, value: jsonString);
  }

  // Remove cart data when logout
  void removeCartData({bool removeCache = false}) {
    emit([]);
    if (removeCache) {
      CacheHelper.removeData(key: cartKey);
    }
  }

  /// Calculate total price
  double getTotal() {
    return state.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  bool isInCart(Product product) {
    return state.any((item) => item.product.id == product.id);
  }
}
