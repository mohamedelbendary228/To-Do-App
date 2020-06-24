import 'package:authmabform/app/home_page.dart';
import 'package:authmabform/app/landing_page.dart';
import 'package:authmabform/app/sign_in/sign_in_screen.dart';
import 'package:authmabform/app/welcome_screen/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      body: Container(
        height: mediaQuery.size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/main_top.png',
                width: mediaQuery.size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/main_bottom.png',
                width: mediaQuery.size.width * 0.2,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'WELCOME TO EDU',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.03),
                  SvgPicture.asset(
                    'assets/icons/chat.svg',
                    height: mediaQuery.size.height * 0.45,
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.05),
                  RoundedButton(
                    text: 'LOGIN',
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => StreamBuilder<User>(
                            stream: auth.onAuthStateChanged,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.active) {
                                User user = snapshot.data;
                                if (user == null) {
                                  return SignInScreen();
                                }
                                return HomePage();
                              } else {
                                return Scaffold(
                                  body: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
