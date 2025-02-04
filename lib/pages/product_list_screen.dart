import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../models/category.dart';
import '../widgets/product_card.dart';
import 'product_details_screen.dart';

class ProductListScreen extends StatelessWidget {
  final Category category; // Accept a Category object
  final List<ClothingItem> _products = [
    ClothingItem(
      id: '1',
      name: 'Stylish Jacket',
      description: 'A trendy jacket for men.',
      price: 79.99,
      imageUrl: 'assets/images/t4.png',
      category: 'Men',
    ),
    ClothingItem(
      id: '2',
      name: 'Elegant Dress',
      description: 'A beautiful dress for women.',
      price: 59.99,
      imageUrl: 'lib/assets/images/cards/t10.jpg',
      category: 'Women',
    ),
    // Add more products
  ];

  ProductListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<ClothingItem> categoryProducts = _products.where((product) => product.category == category.name).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('${category.name} Wear', style: const TextStyle(color: Colors.white)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7, // Adjusted to make the cards taller
        ),
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) {
          final product = categoryProducts[index];
          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product)),
              );
            },
          );
        },
      ),
    );
  }
}
