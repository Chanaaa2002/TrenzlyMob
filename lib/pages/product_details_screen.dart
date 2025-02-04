import 'package:flutter/material.dart';
import '../models/clothing_item.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ClothingItem product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(product.name, style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(product.imageUrl, fit: BoxFit.cover, height: 300),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product.name,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Text(
              '\$${product.price}',
              style: const TextStyle(color: Colors.orangeAccent, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product.description,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add to cart logic
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 79, 204, 68)),
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}