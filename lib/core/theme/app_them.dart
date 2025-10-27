import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData light = ThemeData(
   useMaterial3: false,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        shadowColor: Colors.blue,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20))
      )
    )

  );
  static ThemeData dark = ThemeData(
  brightness: Brightness.dark
  );
  static ThemeMode ToggleTheme(){
    return ThemeMode.light;
  }
}