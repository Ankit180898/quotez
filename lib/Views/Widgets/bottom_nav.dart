import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quotez/Views/home_page.dart';
import 'package:quotez/Views/saved_data_screen.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  int index_x = 0;

  final screens = [
    HomePage(),
    SavedDataScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      index_x = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF9354B9),
        body: screens[index_x],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.transparent

            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(

                elevation: 10.0,
                backgroundColor: Color(0xFF4051A9),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark),
                    label: 'Saved',
                  ),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: index_x,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.black.withOpacity(0.5),
                selectedLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                ),
                unselectedLabelStyle: TextStyle(
                  color: Colors.amber,
                  fontSize: 12,
                ),
                iconSize: 30,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

