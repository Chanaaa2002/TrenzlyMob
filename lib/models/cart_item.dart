import 'package:flutter/material.dart'; 
import 'clothing_item.dart'; 

class CartItem {
  final ClothingItem product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}