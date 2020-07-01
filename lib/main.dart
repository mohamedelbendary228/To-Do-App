import 'file:///C:/Users/moham/AndroidStudioProjects/auth_mab_form/lib/landing_page.dart';
import 'package:authmabform/auth_services/auth.dart';
import 'package:authmabform/them_service/app_them.dart';
import 'package:authmabform/them_service/app_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider.value(
          value: AppThemeState(),
        ),
      ],
      child: Consumer<AppThemeState>(
        builder: (_, appState, __) {
          return MaterialApp(
            title: 'ToDo App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appState.isDark? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: LandingPage(),
          );
        },
      ),
    );
  }
}

