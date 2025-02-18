import 'package:flutter/material.dart';
import 'package:madpro/views/cart_screen.dart';
import 'package:madpro/views/profile_screen.dart';
import '../controllers/auth_controller.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart';
import 'product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isDarkMode = false; // Dark mode toggle state
  final AuthController authController = AuthController();
  final List<Map<String, dynamic>> cartItems = [];

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      ProductScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
            onPressed: () {},
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
      body: _pages[_currentIndex],
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

// HomePage with dynamically loaded products
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController _productController = ProductController();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _productController.fetchProducts(); // Fetch products on init
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
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
          Text("Popular Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
          SizedBox(height: 10),
          
          // Use FutureBuilder to handle product fetching dynamically
          FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Failed to load products.", style: TextStyle(color: textColor)));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("No products available.", style: TextStyle(color: textColor)));
              }

              final products = snapshot.data!;

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    name: product.name,
                    description: product.description,
                    price: "Rs. ${product.price.toStringAsFixed(2)}",
                    imagePath: product.images.isNotEmpty ? product.images[0] : 'assets/images/placeholder.png',
                    isDarkMode: isDarkMode,
                    onTap: () {
                      // Handle product tap
                    },
                    onAddToCart: () {
                      // Handle add to cart
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// Category Button
class CategoryButton extends StatelessWidget {
  final String label;
  final bool isDarkMode;

  const CategoryButton({super.key, required this.label, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[300],
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: TextStyle(fontSize: 14)),
    );
  }
}
