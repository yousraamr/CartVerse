import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../cubit/wishlist_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../utils/snackbar.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isWishlist;

  const ProductCard({
    Key? key,
    required this.product,
    this.isWishlist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistCubit = context.read<WishlistCubit>();
    final cartCubit = context.read<CartCubit>();
    final isInWishlist = wishlistCubit.isInWishlist(product);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(product.image, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('\$${product.price}', style: const TextStyle(color: Colors.orange)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        isInWishlist ? Icons.favorite : Icons.favorite_border,
                        color: isInWishlist ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        if (isInWishlist) {
                          wishlistCubit.removeFromWishlist(product);
                          showSuccessSnackBar(context, '${product.name} removed from wishlist');
                        } else {
                          wishlistCubit.addToWishlist(product);
                          showSuccessSnackBar(context, '${product.name} added to wishlist');
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.blue),
                      onPressed: () {
                        cartCubit.addToCart(product);
                        showSuccessSnackBar(context, '${product.name} added to cart');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
