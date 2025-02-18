import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../models/product.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String selectedPaymentMethod = "Credit Card"; // Default payment method

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.teal,
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🛒 Order Summary
              Text("Order Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black26 : Colors.grey.shade300,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.cartItems[index];
                    final Product product = item['product']; // Fix: Access product as object

                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.images.isNotEmpty ? product.images[0] : 'assets/images/placeholder.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/placeholder.png', width: 50, height: 50, fit: BoxFit.cover);
                          },
                        ),
                      ),
                      title: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                      subtitle: Text("Qty: ${item['quantity']}", style: TextStyle(color: textColor)),
                      trailing: Text(
                        "Rs. ${(product.price * item['quantity']).toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 📍 Shipping Address Section
              Text("Shipping Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 10),
              _buildTextField("Full Name", nameController, Icons.person, isDarkMode),
              const SizedBox(height: 10),
              _buildTextField("Address", addressController, Icons.location_on, isDarkMode),
              const SizedBox(height: 10),
              _buildTextField("Phone Number", phoneController, Icons.phone, isDarkMode),
              const SizedBox(height: 20),

              // 💳 Payment Method
              Text("Payment Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedPaymentMethod,
                items: ["Credit Card", "Debit Card", "Cash on Delivery"]
                    .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),

              // 💰 Total Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
                  Text(
                    "Rs. ${cartProvider.calculateTotal().toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ✅ Place Order Button
              ElevatedButton(
                onPressed: () {
                  _placeOrder(cartProvider);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Center(
                  child: Text("Place Order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 📌 Input Field Widget
  Widget _buildTextField(String label, TextEditingController controller, IconData icon, bool isDarkMode) {
    return TextField(
      controller: controller,
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // 🛒 Place Order Logic
  void _placeOrder(CartProvider cartProvider) {
    if (nameController.text.isEmpty || addressController.text.isEmpty || phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    // ✅ Success Message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order Placed Successfully!")),
    );

    cartProvider.clearCart(); // Clear cart after order
    Navigator.pop(context); // Go back after placing order
  }
}
