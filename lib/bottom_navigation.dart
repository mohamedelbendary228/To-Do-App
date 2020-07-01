import 'package:authmabform/account.dart';
import 'package:authmabform/auth_services/auth.dart';
import 'package:authmabform/crud_services/edit_job_screen.dart';
import 'package:authmabform/home/home_page.dart';
import 'package:authmabform/them_service/app_theme_state.dart';
import 'package:authmabform/widgest/platform_alert_dailog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<Map<String, Object>> _pages;

  @override
  initState() {
    _pages = [
      {
        'page': HomePage(),
        'title': 'Welcome',
      },
      {
        'page': Account(),
        'title': 'Account',
      },
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        actions: <Widget>[
          if (_pages[_selectedPageIndex]['title'] == 'Welcome')
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => EditJobPage.show(context),
                ),
                SizedBox(width: 10),
                Consumer<AppThemeState>(
                  builder: (context, themeState, child) => Switch(
                    onChanged: (newValue) {
                      themeState.toggleTheme();
                    },
                    value: themeState.isDark,
                  ),
                )
              ],
            ),
          if (_pages[_selectedPageIndex]['title'] == 'Account')
            FlatButton(
              textColor: Colors.white,
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => _confirmSignOut(context),
            ),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 23),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 23),
            title: Text('Account'),
          ),
        ],
      ),
    );
  }
}
