import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../widgets/input_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = AuthController();

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  // Fetch user details from the database
  void _fetchUserDetails() async {
    var user = await authController.getUserDetails();
    if (user != null) {
      setState(() {
        nameController.text = user.name ?? "";
        emailController.text = user.email ?? "";
      });
    }
  }

  // Save changes to the database
  void _saveChanges() async {
    bool isUpdated = await authController.updateUserDetails(
      nameController.text,
      emailController.text,
      passwordController.text.isNotEmpty ? passwordController.text : null,
    );

    if (isUpdated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile. Please try again.")),
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
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/profile_banner.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('lib/assets/images/user_avatar.jpg'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Title
            Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Make changes to your account details below.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontFamily: "Poppins",
              ),
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
                    label: "Email Address",
                    controller: emailController,
                    icon: Icons.email_outlined,
                  ),
                  SizedBox(height: 24),
                  InputField(
                    label: "New Password (Optional)",
                    controller: passwordController,
                    isPassword: true,
                    icon: Icons.lock_outline,
                  ),
                  SizedBox(height: 24),
                  // Save Changes Button
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[300],
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      "Save Changes",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: "Poppins"),
                    ),
                  ),
                ],
              ),
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
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
