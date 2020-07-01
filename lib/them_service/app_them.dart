import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

//  static Color _lightGrayColor = Colors.grey;
//
//  static const _lightPrimaryColor = Color(0xFF6F35A5);
//  static const _lightScaffoldColor = Colors.white;
//
//  static final TextStyle _lightText = TextStyle(color: Colors.black);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.white,
    accentColor: Color(0xFF6F35A5),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
  );
}
