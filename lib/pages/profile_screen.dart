import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String _username = 'John Doe';  
  final String _email = 'johndoe@gmail.com';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/assets/images/profile.jpg'),  // Placeholder profile image
            ),
            const SizedBox(height: 16),
            const Text('Username:', style: TextStyle(color: Colors.white70)),
            Text(_username, style: const TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Email:', style: TextStyle(color: Colors.white70)),
            Text(_email, style: const TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 79, 204, 68)),
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}