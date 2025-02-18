import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Product product, String size, String color) {
    final existingIndex = _cartItems.indexWhere(
        (item) => item['product'].id == product.id && item['size'] == size && item['color'] == color);

    if (existingIndex != -1) {
      _cartItems[existingIndex]['quantity'] += 1;
      _cartItems[existingIndex]['total'] = _cartItems[existingIndex]['product'].price * _cartItems[existingIndex]['quantity'];
    } else {
      _cartItems.add({
        'product': product,
        'size': size,
        'color': color,
        'quantity': 1,
        'total': product.price,
      });
    }
    
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity > 0) {
      _cartItems[index]['quantity'] = quantity;
      _cartItems[index]['total'] = _cartItems[index]['product'].price * quantity;
    } else {
      _cartItems.removeAt(index);
    }
    
    notifyListeners();
  }

  double calculateTotal() {
    return _cartItems.fold(0, (total, item) => total + item['total']);
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
