import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../models/cart_item_model.dart';
import '../cubit/wishlist_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../utils/snackbar.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isWishlist;
  final bool isCart;

  const ProductCard({
    Key? key,
    required this.product,
    this.isWishlist = false,
    this.isCart = false,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(product.image, fit: BoxFit.cover, width: double.infinity),
            ),
          ),

          // Product Info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('\$${product.price}', style: const TextStyle(color: Colors.orange)),
                const SizedBox(height: 8),

                // Action Buttons (Wishlist + Cart)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // wishlist Button
                    BlocBuilder<WishlistCubit, List<Product>>(
                      builder: (context, wishlist) {
                        final isInWishlist = wishlist.any((item) => item.id == product.id);

                        return IconButton(
                          icon: Icon(
                            isInWishlist ? Icons.favorite : Icons.favorite_border,
                            color: isInWishlist ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            final wishlistCubit = context.read<WishlistCubit>();
                            if (isInWishlist) {
                              wishlistCubit.removeFromWishlist(product);
                              showSuccessSnackBar(context, '${product.name} removed from wishlist');
                            } else {
                              wishlistCubit.addToWishlist(product);
                              showSuccessSnackBar(context, '${product.name} added to wishlist');
                            }
                          },
                        );
                      },
                    ),

                    // cart Button
                    BlocBuilder<CartCubit, List<CartItem>>(
                      builder: (context, cart) {
                        final isInCart = cart.any((item) => item.product.id == product.id);

                        return IconButton(
                          icon: Icon(
                            isInCart ? Icons.check_circle : Icons.shopping_cart,
                            color: isInCart ? Colors.green : Colors.blue,
                          ),
                          onPressed: () {
                            if (isInCart) {
                              context.read<CartCubit>().removeFromCart(product);
                              showSuccessSnackBar(context, '${product.name} removed from cart');
                            } else {
                              context.read<CartCubit>().addToCart(product);
                              showSuccessSnackBar(context, '${product.name} added to cart');
                            }
                          },
                        );
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
