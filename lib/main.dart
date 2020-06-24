import 'package:authmabform/app/landing_page.dart';
import 'package:authmabform/app/welcome_screen/welcome_screen.dart';
import 'package:authmabform/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './services/auth.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'Auth Form',
        theme: ThemeData(
          indicatorColor: Color(0xFF6F35A5),
          primaryColor: Color(0xFF6F35A5),
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}

// const kPrimaryLightColor = Color(0xFFF1E6FF);
