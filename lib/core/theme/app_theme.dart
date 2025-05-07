import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF4CAF50),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF4CAF50),
    secondary: Color(0xFF009688),
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFF0F4F8),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onSurface: Color(0xFF212121),
  ),
  scaffoldBackgroundColor: const Color(0xFFF0F4F8),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF81C784),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF81C784),
    secondary: Color(0xFF4DB6AC),
    surface: Color(0xFF1E1E1E),
    background: Color(0xFF121212),
    onPrimary: Color(0xFF000000),
    onSecondary: Color(0xFF000000),
    onSurface: Color(0xFFE0E0E0),
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
); 
