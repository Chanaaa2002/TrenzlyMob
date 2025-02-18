import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedSize;
  String? selectedColor;
  int quantity = 1;

  void addToCart() {
    // Mocked Add to Cart functionality for now
    final totalAmount = (widget.product.price ?? 0) * quantity;

    Navigator.pop(context, {
      "product": widget.product,
      "size": selectedSize,
      "color": selectedColor,
      "quantity": quantity,
      "total": totalAmount,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product.name} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.teal,
        title: Text(
          widget.product.name ?? 'Product Details',
          style: TextStyle(color: textColor),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.product.images.isNotEmpty
                    ? widget.product.images[0]
                    : 'lib/assets/images/placeholder.png',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Product Name and Price
            Text(
              widget.product.name ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 8),
            Text(
              "\$${widget.product.price.toStringAsFixed(2) ?? '0.0'}",
              style: const TextStyle(fontSize: 20, color: Colors.teal, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Size Selector
            Text(
              "Select Size",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
            ),
            Wrap(
              spacing: 8,
              children: ['S', 'M', 'L', 'XL'].map((size) {
                return ChoiceChip(
                  label: Text(size),
                  selected: selectedSize == size,
                  onSelected: (selected) {
                    setState(() {
                      selectedSize = size;
                    });
                  },
                  backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  selectedColor: Colors.teal,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Color Selector
            Text(
              "Select Color",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
            ),
            Wrap(
              spacing: 8,
              children: ['Red', 'Blue', 'Green', 'Black'].map((color) {
                return ChoiceChip(
                  label: Text(color),
                  selected: selectedColor == color,
                  onSelected: (selected) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  selectedColor: Colors.teal,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Quantity Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Quantity",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Add to Cart Button
            ElevatedButton(
              onPressed: addToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Add to Cart",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
