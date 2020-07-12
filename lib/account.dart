import 'package:authmabform/auth_services/auth.dart';
import 'package:authmabform/sidebar_navigation/navigation_bloc.dart';
import 'package:authmabform/widgest/avatar.dart';
import 'package:authmabform/widgest/platform_alert_dailog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatelessWidget with NavigationStates{

  Future<void> _signOut(context) async {
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      await auth.signOut();
    } catch (e) {}
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to lougout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: Column(
              children: <Widget>[
                Avatar(
                  photoUrl: user.photoUrl,
                  radius: 50,
                ),
                SizedBox(height: 10),
                if(user.displayName != null)
                  Text(user.displayName, style: TextStyle(color: Colors.white),),
                SizedBox(height: 10),
              ],
            )
        ),
      ),
    );
  }
}
