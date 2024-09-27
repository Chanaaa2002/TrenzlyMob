import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String _username = 'John Doe';  
  final String _email = 'johndoe@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/assets/images/profile.jpg'),  // Placeholder profile image
            ),
            SizedBox(height: 16),
            Text('Username:', style: TextStyle(color: Colors.white70)),
            Text(_username, style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 16),
            Text('Email:', style: TextStyle(color: Colors.white70)),
            Text(_email, style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                
              },
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 79, 204, 68)),
            ),
          ],
        ),
      ),
    );
  }
}