import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../view/product_card.dart';
import '../data/mock_products.dart';

class ProductListPage extends StatelessWidget {
  final String categoryName;

  const ProductListPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter products based on category
    final products = mockProducts.where((p) => p.category == categoryName).toList();

    return Scaffold(
      appBar: AppBar(title: Text('$categoryName Products')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return ProductCard(
                product: products[index],
            );
          },
        ),
      ),
    );
  }
}
