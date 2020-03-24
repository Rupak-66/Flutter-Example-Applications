import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class Home extends StatelessWidget {
  final List<BottomNavigationBarItem> _navItems = [
    //* Favorites
    BottomNavigationBarItem(
        icon: Icon(Icons.star_border), title: Text("Favorites")),

    //* Recents
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.time), title: Text("Recents")),

    //* Contacts
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text("Contacts")),
    //* KeyPad
    BottomNavigationBarItem(icon: Icon(Icons.dialpad), title: Text("Keypad")),
    //* Voicemail
    BottomNavigationBarItem(
        icon: Icon(Icons.voicemail), title: Text("Voicemail")),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Logic>(
      builder: (_, logic, child) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          showUnselectedLabels: true,
          items: _navItems,
          currentIndex: logic.selectedIndex,
          selectedItemColor: Colors.lightGreenAccent,
          onTap: logic.onNavItemTapped,
        ),
        body: SafeArea(child: logic.switchPage()),
      ),
    );
  }
}
