//import 'package:authmabform/widgest/platform_excption_alert_dailog.dart';
//import 'package:authmabform/widgest/social_sign_in_buttons.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:provider/provider.dart';
//
//import '../../services/auth.dart';
//
//class SocialSignIn extends StatefulWidget {
//
//  bool isLoading;
//  SocialSignIn({this.isLoading});
//  @override
//  _SocialSignInState createState() => _SocialSignInState();
//}
//
//class _SocialSignInState extends State<SocialSignIn> {
//  void _showSignInError(BuildContext context, PlatformException exception) {
//    PlatformExceptionAlertDialog(
//      title: 'Sign in failed',
//      exception: exception,
//    ).show(context);
//  }
//
//  Future<void> _signInAnonymously(context) async {
//    try {
//      setState(() => widget.isLoading = !widget.isLoading);
//      final auth = Provider.of<Auth>(context, listen: false);
//      await auth.signInAnonymously();
//    } on PlatformException catch (e) {
//      _showSignInError(context, e);
//    } finally {
//      setState(() => widget.isLoading = widget.isLoading);
//    }
//  }
//
//  Future<void> _signInWithGoogle(context) async {
//    final auth = Provider.of<Auth>(context, listen: false);
//    try {
//      setState(() => widget.isLoading = !widget.isLoading);
//      await auth.signInWithGoogle();
//    } on PlatformException catch (e) {
//      if (e.code != 'ERROR_ABORTED_BY_USER') {
//        _showSignInError(context, e);
//      }
//    } finally {
//      setState(() => widget.isLoading = widget.isLoading);
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        SocialSignInIcons(
//          image: 'assets/icons/facebook.svg',
//          onTap: () {},
//        ),
//        SocialSignInIcons(
//          image: 'assets/icons/anonymous.svg',
//          onTap: () => _signInAnonymously(context),
//        ),
//        SocialSignInIcons(
//          image: 'assets/icons/google-plus.svg',
//          onTap: () => _signInWithGoogle(context),
//        ),
//      ],
//    );
//  }
//}
