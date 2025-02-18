import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart';

import 'product_details.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductController _productController = ProductController();
  List<Product> products = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final fetchedProducts = await _productController.fetchProducts();
      print("Fetched Products Count: ${fetchedProducts.length}");

      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading products: $e");
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.teal,
        title: Text('Products', style: TextStyle(color: textColor)),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
              ? const Center(child: Text("Failed to load products."))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return ProductCard(
                        name: product.name,
                        description: product.description,
                        price: "Rs. ${product.price.toStringAsFixed(2)}",
                        imagePath: product.images.isNotEmpty
                            ? product.images[0]
                            : 'assets/images/placeholder.png',
                        isDarkMode: isDarkMode,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        onAddToCart: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .addToCart(product, "M", "Blue"); // Default size & color
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${product.name} added to cart!")),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String imagePath;
  final bool isDarkMode;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.isDarkMode,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black26 : Colors.grey.shade300,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: name,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      imagePath,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder.png',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode ? Colors.white70 : Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isDarkMode ? Colors.tealAccent.shade700 : Colors.teal.shade100,
                          ),
                          child: Text(
                            price,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.black : Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: FloatingActionButton(
                heroTag: name,
                onPressed: onAddToCart,
                mini: true,
                backgroundColor: isDarkMode ? Colors.tealAccent : Colors.teal,
                child: const Icon(Icons.add_shopping_cart, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
