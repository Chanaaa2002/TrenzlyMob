import 'package:flutter/material.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart';
import 'views/home_screen.dart';
import 'package:provider/provider.dart';
import 'provider/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/home": (context) => HomeScreen(),
      },
    );
  }
}
