import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../utils/cache_helper.dart';

class WishlistCubit extends Cubit<List<Product>> {
  WishlistCubit() : super([]);

  static const String wishlistKey = 'wishlist';

  void loadWishlist() {
    final data = CacheHelper.getString(key: wishlistKey);
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      emit(jsonList.map((e) => Product.fromMap(Map<String, dynamic>.from(e))).toList());
    }
  }

  void addToWishlist(Product product) {
    final updatedList = List<Product>.from(state);
    if (!updatedList.any((item) => item.id == product.id)) {
      updatedList.add(product);
      emit(updatedList);
      _saveWishlist(updatedList);
    }
  }

  void removeFromWishlist(Product product) {
    final updatedList = List<Product>.from(state)..removeWhere((item) => item.id == product.id);
    emit(updatedList);
    _saveWishlist(updatedList);
  }

  void _saveWishlist(List<Product> wishlist) {
    final jsonString = jsonEncode(wishlist.map((e) => e.toMap()).toList());
    CacheHelper.saveString(key: wishlistKey, value: jsonString);
  }

  void clearWishlist({bool removeCache = false}) {
    emit([]);
    if (removeCache) {
      CacheHelper.removeData(key: wishlistKey);
    }
  }

  bool isInWishlist(Product product) {
    return state.any((item) => item.id == product.id);
  }
}
