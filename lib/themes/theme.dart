import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), // Updated for newer Flutter versions
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // Replaces bodyText1
    bodyMedium: TextStyle(color: Colors.black), // Replaces bodyText2
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.orangeAccent,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent), // Updated for newer Flutter versions
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // Replaces bodyText1
    bodyMedium: TextStyle(color: Colors.white), // Replaces bodyText2
  ),
);