import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../widgets/input_field.dart';
import 'register_screen.dart';
import 'home_screen.dart'; // Add this line to import HomeScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = AuthController();

  



    void login() async {
  try {
    var user = await authController.login(emailController.text, passwordController.text);

    print("User Data Received: $user"); // Debugging log

    if (user.user != null && user.user!.token != null) {
      print("Login successful. Navigating to HomeScreen...");

      // Navigate to HomeScreen on successful login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    } else {
      print("Invalid credentials or missing token.");

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid credentials. Please try again.")),
      );
    }
  } catch (e) {
    print("Error during login: $e");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An error occurred. Please try again.")),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Banner with curved border
            ClipPath(
              clipper: CurvedClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/catwome.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Welcome Text
            Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            Text(
              "Log in with your data that you entered during your registration.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600], fontFamily: "Poppins"),
            ),
            SizedBox(height: 24),
            // Input Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  InputField(
                    label: "Email address",
                    controller: emailController,
                    icon: Icons.email_outlined,
                  ),
                  SizedBox(height: 24),
                  InputField(
                    label: "Password",
                    controller: passwordController,
                    isPassword: true,
                    icon: Icons.lock_outline,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {}, // Forgot password functionality
                      child: Text("Forgot password?", style: TextStyle(color: Colors.teal)),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Login Button
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[100],
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      "Log in",
                      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Poppins"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Register Navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
               GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Curved Clipper for the Banner
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
