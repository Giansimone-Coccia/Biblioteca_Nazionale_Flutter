import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xFF6D77FB),
    //accentColor: Colors.orange,
    backgroundColor: Colors.white,
    // altre proprietà del tema
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF6D77FB),
   // accentColor: Colors.teal,
    //fontFamily: 'Roboto',
    backgroundColor: Colors.white,
    // altre proprietà del tema
  );
}