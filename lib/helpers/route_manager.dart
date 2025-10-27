import 'package:flutter/material.dart';
import 'package:soqsoq/core/views/screens/home_screen.dart';
import 'package:soqsoq/core/views/screens/login_screen.dart';
import 'package:soqsoq/core/views/screens/notfound_404.dart';
import 'package:soqsoq/core/views/screens/registration_screen.dart';
import 'package:soqsoq/core/views/screens/splash_screen.dart';

class RouteManager {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(builder: (ctx) => HomeScreen());
      case "/login":
        return MaterialPageRoute(builder: (ctx) => LoginScreen());
      case "/register":
        return MaterialPageRoute(builder: (ctx) => RegistrationScreen());
      case "/splash":
        return MaterialPageRoute(builder: (ctx) => SplashScreen());
      default:
        return MaterialPageRoute(builder: (ctx) => Notfound404());
    }
  }
}
