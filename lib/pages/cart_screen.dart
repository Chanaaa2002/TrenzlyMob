import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample cart items
  final List<CartItem> _cartItems = [
    CartItem(
      product: ClothingItem(
        id: '3',
      name: 'Dress',
      description: 'A trendy dress for women.',
      price: 59.99,
      imageUrl: 'lib/assets/images/cards/t10.jpg',
      category: 'Women',

    ),
      quantity: 2,
    ),
     
    CartItem(
      product: ClothingItem(
       id: '2',
      name: 'T-Shirt',
      description: 'A trendy t-shirt for men.',
      price: 29.99,
      imageUrl: 'lib/assets/images/cards/t6.jpg',
      category: 'Men',
    ),
      quantity: 1,
    ),
  ];

  void _removeFromCart(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Cart', style: TextStyle(color: Colors.white)),
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: Text('Your cart is empty!', style: TextStyle(color: Colors.white)),
            )
          : ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = _cartItems[index];
                return ListTile(
                  leading: Image.asset(cartItem.product.imageUrl, width: 50, fit: BoxFit.cover),
                  title: Text(cartItem.product.name, style: TextStyle(color: Colors.white)),
                  subtitle: Text('Quantity: ${cartItem.quantity}', style: TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      _removeFromCart(index);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Implement checkout logic
          },
          child: Text('Proceed to Checkout'),
          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 79, 204, 68),
          ),
        ),
      ),
    );
  }
}