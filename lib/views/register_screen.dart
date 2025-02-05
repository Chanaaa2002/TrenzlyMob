import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../widgets/input_field.dart';
import 'login_screen.dart';
import 'home_screen.dart'; // Add this line to import HomeScreen

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = AuthController();

void register() async {
    var user = await authController.register(
      nameController.text,
      emailController.text,
      passwordController.text,
    );

    // Navigate to HomeScreen on successful registration
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
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
                    image: AssetImage('lib/assets/images/shop1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Title Text
            Text(
              "Let's Get Started!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            Text(
              "Please enter your valid data to create an account.",
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
                    label: "Name",
                    controller: nameController,
                    icon: Icons.person_outline,
                  ),
                  SizedBox(height: 24),
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
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Checkbox(
                        value: false, // Default for now
                        onChanged: (value) {},
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "I agree with the ",
                            children: [
                              TextSpan(
                                text: "Terms of service",
                                style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: " & privacy policy."),
                            ],
                          ),
                          style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Register Button
                  ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[100],
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Poppins"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Login Navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "Log in",
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
