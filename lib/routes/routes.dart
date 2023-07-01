import 'package:flutter/material.dart';
import '../main.dart';
import '/screens/homepage.dart';
import '/screens/login.dart';
import '/screens/register.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String homepage = '/homepage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case login:
        return MaterialPageRoute(builder: (_) => Login());
      case registration:
        return MaterialPageRoute(builder: (_) => Register());
      case homepage:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
