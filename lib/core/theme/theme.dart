// Enhanced Monochrome Light Theme
import 'package:flutter/material.dart';

final ThemeData monochromeLightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: Colors.grey.shade700,
    onSecondary: Colors.white,
    surface: const Color.fromARGB(255, 217, 214, 214),
    onSurface: Colors.black,
    surfaceContainerHighest: Colors.grey.shade300,
    secondaryContainer: Colors.grey.shade200, // Operator buttons
    error: Colors.red.shade700,
    onError: Colors.white,
    // New colors for active operator
    tertiary: Colors.black87, // Active operator background
    onTertiary: Colors.white, // Active operator text
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 4,
      shadowColor: Colors.black26,
    ),
  ),
);

// Enhanced Monochrome Dark Theme
final ThemeData monochromeDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.grey.shade400,
    onSecondary: Colors.black,
    surface: Color(0xFF212121),
    onSurface: Colors.white,
    surfaceContainerHighest: Color(0xFF333333),
    secondaryContainer: Color(0xFF424242), // Operator buttons
    error: Colors.redAccent.shade200,
    onError: Colors.black,
    // New colors for active operator
    tertiary: Colors.white70, // Active operator background
    onTertiary: Colors.black, // Active operator text
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 6, 6, 6),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 4,
      shadowColor: Colors.black45,
    ),
  ),
);
