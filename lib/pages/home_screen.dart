import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../models/category.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_card.dart';
import '../widgets/banner_image.dart';
import '../widgets/bottom_nav_bar.dart';
import 'categories_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'settings.dart';
import 'product_list_screen.dart';
import 'product_details_screen.dart';
import 'signin.dart';
import 'register.dart'; 

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle; // Add the onThemeToggle parameter

  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2; // Home index
  final TextEditingController _searchController = TextEditingController();

  final List<ClothingItem> _featuredProducts = [
    ClothingItem(
      id: '1',
      name: 'Hoodie',
      description: 'A trendy jacket for men.',
      price: 79.99,
      imageUrl: 'lib/assets/images/cards/t5.jpg',
      category: 'Men',
    ),
    ClothingItem(
      id: '2',
      name: 'T-Shirt',
      description: 'A trendy t-shirt for men.',
      price: 29.99,
      imageUrl: 'lib/assets/images/cards/t6.jpg',
      category: 'Men',
    ),
    ClothingItem(
      id: '3',
      name: 'Dress',
      description: 'A trendy dress for women.',
      price: 59.99,
      imageUrl: 'lib/assets/images/cards/t10.jpg',
      category: 'Women',
    ),
    ClothingItem(
      id: '4',
      name: 'Dress',
      description: 'A trendy dress for women.',
      price: 59.99,
      imageUrl: 'lib/assets/images/cards/t14.jpg',
      category: 'Women',
    ),
  ];

  final List<Category> _categories = [
    Category(
      id: '1', name: 'Men\'s Wear', imageUrl: 'lib/assets/images/mens.png'),
    Category(
      id: '2', name: 'Women\'s Wear', imageUrl: 'lib/assets/images/womens.png'),
    Category(
      id: '3', name: 'Accessories', imageUrl: 'lib/assets/images/acces.jpg')
  ];

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index != 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          switch (index) {
            case 0:
              return CategoriesScreen();
            case 1:
              return ProfileScreen();
            case 3:
              return CartScreen();
            case 4:
              return SettingsScreen();
            default:
              return HomeScreen(
                onThemeToggle: widget.onThemeToggle); // Ensure theme toggle is passed
          }
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Row(
          children: [
            Image.asset('lib/assets/images/logo.png', height: 40),
            const SizedBox(width: 10),
            Text('TRENZLY',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 24)),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.brightness_6, color: Colors.orangeAccent),
              onPressed: widget.onThemeToggle, // Use the callback to toggle theme
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.person, color: Colors.orangeAccent), // User icon for the sign-in/register menu
              onSelected: (value) {
                if (value == 'Sign In') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                } else if (value == 'Register') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Sign In',
                  child: Text('Sign In'),
                ),
                const PopupMenuItem<String>(
                  value: 'Register',
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            SearchBar(controller: _searchController),

            // Banner Image
            BannerImage(imageUrl: 'lib/assets/images/Banner.jpg'),

            // Categories Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Categories',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return CategoryCard(
                    category: category,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductListScreen(category: category)),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            // Featured Products Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular Products',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      // Navigate to all products screen
                    },
                    child: const Text('View All',
                        style: TextStyle(
                            color: Colors.orangeAccent, fontSize: 16)),
                  ),
                ],
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: _featuredProducts.length,
              itemBuilder: (context, index) {
                final product = _featuredProducts[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsScreen(product: product)),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTapped,
      ),
    );
  }
}
