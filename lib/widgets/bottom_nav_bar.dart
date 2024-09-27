import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_2), label: ''),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.home, color: Colors.black, size: 30),
          ),
          label: '',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
      ],
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
    );
  }
}
