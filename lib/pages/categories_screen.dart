import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> _categories = [
    Category ( id: '1', name: 'Men\'s Wear', imageUrl: 'lib/assets/images/mens.png'),
    Category(id: '2',
        name: 'Women\'s Wear',
        imageUrl: 'lib/assets/images/womens.png'),
    Category(
        id: '3', name: 'Acccessories', imageUrl: 'lib/assets/images/acces.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Categories', style: TextStyle(color: Colors.white)),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return CategoryCard(
            category: category,
            onTap: () {
              // Navigate to product list screen
            },
          );
        },
      ),
      
    );
  }
}