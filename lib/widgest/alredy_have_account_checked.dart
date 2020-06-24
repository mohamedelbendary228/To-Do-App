//import 'package:flutter/material.dart';
//
//class AlreadyHaveAccountChecked extends StatelessWidget {
//  final bool login;
//  final Function onTap;
//
//  AlreadyHaveAccountChecked({
//    this.login = true,
//    this.onTap,
//});
//  @override
//  Widget build(BuildContext context) {
//    var mediaQuery = MediaQuery.of(context).size;
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Text(
//          login ? "Don't have an account ? " : "Already have an account ? ",
//          style: TextStyle(color: Theme
//              .of(context)
//              .primaryColor),
//        ),
//        SizedBox(height: mediaQuery.height * 0.03),
//        GestureDetector(
//          onTap: onTap,
//          child: Text(
//            login ? "Sign Up" : "Sign In",
//            style: TextStyle(
//              color: Theme
//                  .of(context)
//                  .primaryColor,
//              fontWeight: FontWeight.bold,
//            ),
//          ),
//        ),
//      ],
//    );
////  }
//}
