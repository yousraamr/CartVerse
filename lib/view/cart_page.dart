import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/order_cubit.dart';
import '../models/cart_item_model.dart';
import '../utils/snackbar.dart';
import '../utils/cache_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr("cart_title"))),
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cart) {
          if (cart.isEmpty) {
            return Center(child: Text(tr("cart_empty")));
          }
          final totalPrice = cart.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final item = cart[index];
                    return Card(
                      child: ListTile(
                        leading: item.product.image.isNotEmpty
                            ? Image.network(
                          item.product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                            : const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                         title: Text(item.product.name),
                        subtitle: Text('${tr("cart_price_label")}: \$${item.product.price} x ${item.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (item.quantity > 1) {
                                  context.read<CartCubit>().updateQuantity(item.product, item.quantity - 1);
                                } else {
                                  context.read<CartCubit>().removeFromCart(item.product);
                                }
                              },
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                context.read<CartCubit>().updateQuantity(item.product, item.quantity + 1);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '${tr("cart_total")}: \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () async {
                        final userId = CacheHelper.getString(key: 'userId') ?? '';
                        if (userId.isEmpty) {
                          showErrorSnackBar(context, 'Please login first!');
                          return;
                        }

                        final cart = context.read<CartCubit>().state;
                        final totalPrice = context.read<CartCubit>().getTotal();

                        try {
                          await context.read<OrderCubit>().placeOrder(
                            // userId: userId,
                            items: cart,
                            totalPrice: totalPrice,
                          );

                          context.read<CartCubit>().clearCart();
                          showSuccessSnackBar(context, "Order placed successfully!");
                        } catch (e) {
                          showErrorSnackBar(context, "Failed to place order: $e");
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text("Place Order"),
                    ),




                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {
                        context.read<CartCubit>().clearCart();
                        showSuccessSnackBar(context, tr("cart_cleared"));
                      },
                      child: Text(tr("cart_clear")),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
