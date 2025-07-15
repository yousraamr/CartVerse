import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/wishlist_cubit.dart';
import '../models/product_model.dart';
import '../view/product_card.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Wishlist")),
      body: BlocBuilder<WishlistCubit, List<Product>>(
        builder: (context, wishlist) {
          if (wishlist.isEmpty) {
            return const Center(child: Text("Your wishlist is empty."));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: wishlist.length,
            itemBuilder: (context, index) {
              final product = wishlist[index];
              return ProductCard(product: product, isWishlist: true);
            },
          );
        },

      ),
    );
  }
}