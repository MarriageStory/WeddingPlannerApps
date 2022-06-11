// ignore_for_file: implementation_imports, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wedding_planner/screens/homePage/homePage.dart';
import 'package:wedding_planner/screens/task/task_screen.dart';
import 'package:wedding_planner/screens/payment/payment_screen.dart';
import 'package:wedding_planner/screens/teams/teams_screen.dart';
import 'package:wedding_planner/screens/other/other_screen.dart';

class BaseScreen extends StatefulWidget {
  int index;
  BaseScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState(index);
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex;
  _BaseScreenState(this._selectedIndex);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    homePage(),
    TaskScreen(),
    PaymentPage(),
    TeamScreen(),
    OtherScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            // activeIcon: homePage(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_style),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Payment',
            // activeIcon: PaymentPage(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Teams',
            // activeIcon: TeamScreen(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[200],
        unselectedItemColor: Colors.grey[400],
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
