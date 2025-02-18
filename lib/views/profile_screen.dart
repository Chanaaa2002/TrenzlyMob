import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:image_picker/image_picker.dart';
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
  final Battery _battery = Battery();
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  String _connectionStatus = "Checking...";
  int _batteryLevel = 100;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _checkConnectivity();
    _getBatteryStatus();
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

  // Check network connectivity
  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      if (connectivityResult == ConnectivityResult.mobile) {
        _connectionStatus = "Connected (Mobile)";
      } else if (connectivityResult == ConnectivityResult.wifi) {
        _connectionStatus = "Connected (Wi-Fi)";
      } else {
        _connectionStatus = "No Internet Connection";
      }
    });
  }

  // Get battery status
  void _getBatteryStatus() async {
    int batteryLevel = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  // Pick Image from Camera or Gallery
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
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
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!) as ImageProvider
                            : AssetImage('lib/assets/images/user_avatar.jpg'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _showImagePickerOptions(),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal,
                            ),
                            padding: EdgeInsets.all(6),
                            child: Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Edit Profile",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor)),
            const SizedBox(height: 10),
            Text(
              "Make changes to your account details below.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: isDarkMode ? Colors.grey[300] : Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Connectivity & Battery Info
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[900] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.wifi, color: textColor),
                            const SizedBox(width: 8),
                            Text("Network: $_connectionStatus", style: TextStyle(fontSize: 14, color: textColor)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.battery_charging_full, color: textColor),
                            const SizedBox(width: 8),
                            Text("Battery: $_batteryLevel%", style: TextStyle(fontSize: 14, color: textColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  InputField(label: "Name", controller: nameController, icon: Icons.person_outline),
                  const SizedBox(height: 20),
                  InputField(label: "Email Address", controller: emailController, icon: Icons.email_outlined),
                  const SizedBox(height: 20),
                  InputField(label: "New Password (Optional)", controller: passwordController, isPassword: true, icon: Icons.lock_outline),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[300]),
                    child: Text("Save Changes", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show Image Picker Options
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text("Take a Photo"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text("Choose from Gallery"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}

// Curved Clipper for Banner
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
