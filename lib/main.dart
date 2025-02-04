import 'package:flutter/material.dart';

import 'pages/home_screen.dart';
import 'themes/theme.dart'; 


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark; // Default to dark mode

  void _toggleThemeMode() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme, // Light theme
      darkTheme: darkTheme, // Dark theme
      themeMode: _themeMode, // Current theme mode
      home: HomeScreen(onThemeToggle: _toggleThemeMode), // Pass the toggle function to HomeScreen
    );
  }
}
