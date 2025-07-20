import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../utils/cache_helper.dart';
import '../services/wishlist_service.dart';

class WishlistCubit extends Cubit<List<Product>> {
  final WishlistService wishlistService;

  WishlistCubit(this.wishlistService) : super([]);

  Future<void> loadWishlist() async {
    try {
      final products = await wishlistService.fetchWishlist();
      emit(products);
    } catch (e) {
      emit([]);
    }
  }

  Future<void> addToWishlist(Product product) async {
    await wishlistService.addToWishlist(product);
    await loadWishlist();
  }

  Future<void> removeFromWishlist(Product product) async {
    await wishlistService.removeFromWishlist(product.id.toString());
    await loadWishlist();
  }

  void clearWishlist() => emit([]);
}
