import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/cart_cubit.dart';
import '../models/cart_item_model.dart';
import '../utils/snackbar.dart';

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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final item = cart[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(item.product.image, width: 50),
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
                      '${tr("cart_total")}: \$${cart.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity)).toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
