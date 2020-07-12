//import 'package:authmabform/account.dart';
//import 'package:authmabform/home/home_page.dart';
//import 'package:flutter/material.dart';
//
//class BottomNavigation extends StatefulWidget {
//  @override
//  _BottomNavigationState createState() => _BottomNavigationState();
//}
//
//class _BottomNavigationState extends State<BottomNavigation> {
//  List<Map<String, Object>> _pages;
//
//  @override
//  initState() {
//    _pages = [
//      {
//        'page': HomePage(),
//        'title': 'Welcome',
//      },
//      {
//        'page': Account(),
//        'title': 'Account',
//      },
//    ];
//    super.initState();
//  }
//
//  int _selectedPageIndex = 0;
//
//  void _selectedPage(int index) {
//    setState(() {
//      _selectedPageIndex = index;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: _pages[_selectedPageIndex]['page'],
//      bottomNavigationBar: BottomNavigationBar(
//        onTap: _selectedPage,
//        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//        selectedItemColor: Theme.of(context).accentColor,
//        currentIndex: _selectedPageIndex,
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home, size: 23),
//            title: Text('Home'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.account_circle, size: 23),
//            title: Text('Account'),
//          ),
//        ],
//      ),
//    );
//  }
//}
