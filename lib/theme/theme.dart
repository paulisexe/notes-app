import 'package:flutter/material.dart';

// light mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      background: Colors.grey.shade400,
          primary: Colors.grey.shade600,
      secondary: Colors.grey.shade500,
     inversePrimary: Colors.grey.shade800,

  ),

);
// dark mode
ThemeData darkMode = ThemeData(
brightness: Brightness.dark,
colorScheme: ColorScheme.dark(
background: Colors.grey.shade900,
primary: Colors.grey.shade800,
secondary: Colors.grey.shade700,
inversePrimary: Colors.grey.shade500,

),
);