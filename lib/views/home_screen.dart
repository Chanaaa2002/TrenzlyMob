import 'package:flutter/material.dart';
import 'package:madpro/views/cart_screen.dart';
import 'package:madpro/views/profile_screen.dart';
import '../controllers/auth_controller.dart';
import 'product_screen.dart'; // Import the ProductScreen class

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isDarkMode = false; // Dark mode toggle state
  final AuthController authController = AuthController();
  final List<Map<String, dynamic>> cartItems = []; // Define cartItems

  // Pages for bottom navigation
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      ProductScreen(),
      CartScreen(cartItems: cartItems),
      ProfileScreen(),
    ];
  }

  // Bottom navigation tab handler
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Logout function
  void _logout() async {
    await authController.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isDarkMode ? Colors.black : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.black;
    final activeColor = Colors.teal;
    final inactiveColor = _isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        titleSpacing: 20,
        title: Text(
          "Trenzly",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: textColor),
            onPressed: () {
              // Add search logic here
            },
          ),
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode, color: textColor),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: textColor),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: backgroundColor,
        selectedItemColor: activeColor,
        unselectedItemColor: inactiveColor,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        iconSize: 32,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// Example Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Section
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage('lib/assets/images/banner.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          // Categories Section
          Text(
            "Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryButton(label: "All Categories", isDarkMode: isDarkMode),
              CategoryButton(label: "On Sale", isDarkMode: isDarkMode),
              CategoryButton(label: "Men's", isDarkMode: isDarkMode),
              CategoryButton(label: "Women's", isDarkMode: isDarkMode),
            ],
          ),
          SizedBox(height: 20),
          // Popular Products Section
          Text(
            "Popular Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3,
            ),
            itemCount: 4, // Replace with your product count
            itemBuilder: (context, index) {
              return ProductCard(
                name: "Product $index",
                category: "Category $index",
                price: "\$${(index + 1) * 100}",
                imagePath: 'lib/assets/images/product_$index.jpg', // Provide the image path
                isDarkMode: isDarkMode,
              );
            },
          ),
        ],
      ),
    );
  }
}

// Category Button Widget
class CategoryButton extends StatelessWidget {
  final String label;
  final bool isDarkMode;

  const CategoryButton({super.key, required this.label, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => {},
      onExit: (_) => {},
      child: ElevatedButton(
        onPressed: () {
          // Add your button logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[300],
          foregroundColor: isDarkMode ? Colors.white : Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String category;
  final String price;
  final String imagePath; // Path to the product image
  final bool isDarkMode;

  const ProductCard({super.key, 
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath, // Added imagePath
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // Product Category
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white70 : Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // Product Price
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

