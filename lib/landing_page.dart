import 'package:authmabform/auth_services/auth.dart';
import 'package:authmabform/crud_services/database.dart';
import 'package:authmabform/home/home_page.dart';
import 'package:authmabform/sign_in/sign_in_screen.dart';
import 'package:authmabform/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInScreen();
          }
          return Provider<Database>(
            create: (_) => Database(uid: user.uid),
            child: BottomNavigation(),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
    // HomeScreen
  }
}


