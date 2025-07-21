import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/order_cubit.dart';
import '../models/order_model.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderCubit>().fetchOrders();
    });
  }

  void _showProductDetailsDialog(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Order #${order.orderNumber}"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return ListTile(
                  title: Text(item.product.name),
                  subtitle: Text(
                    "${item.quantity} x ${item.product.price.toStringAsFixed(2)} EGP",
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("orders_close".tr()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6E9),
      appBar: AppBar(
        title: Text("orders_title".tr()),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<OrderCubit, List<Order>>(
        builder: (context, orders) {
          if (orders.isEmpty) {
            return const Center(child: CircularProgressIndicator()); // Better than empty text
          }

          return Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "orders_title".tr(),
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFC78B1E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Text("orders_table_order_number".tr(), style: const TextStyle(color: Colors.white))),
                            Expanded(flex: 1, child: Text("orders_table_items".tr(), style: const TextStyle(color: Colors.white))),
                            Expanded(flex: 1, child: Text("orders_table_total_price".tr(), style: const TextStyle(color: Colors.white))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final order = orders[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black12)],
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(flex: 2, child: Text("${order.orderNumber}")),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Text("${order.items.length} ${"orders_item".tr()}"),
                                        const SizedBox(width: 6),
                                        GestureDetector(
                                          onTap: () => _showProductDetailsDialog(context, order),
                                          child: Text(
                                            "orders_product_details".tr(),
                                            style: const TextStyle(
                                              color: Color(0xFFC78B1E),
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("${order.totalPrice.toStringAsFixed(2)} EGP"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
