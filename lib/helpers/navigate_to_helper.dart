import 'package:flutter/material.dart';
import 'package:soqsoq/core/models/user_info.dart';
import 'package:soqsoq/helpers/route_manager.dart';

class NavigationHelper {
  static void navigateTo(BuildContext context, String screen, {UserInfo? userInfo}) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        RouteManager.generateRoutes(
          RouteSettings(
            name: screen,
            arguments: userInfo,
          ),
        ),
      );
    });
  }
}
