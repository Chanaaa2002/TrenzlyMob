import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final TextEditingController controller;

  const Search({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search for products...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[800], // For dark mode
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}