import 'package:calculator/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'core/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorPage(),
      themeMode: ThemeMode.system,
      theme: monochromeLightTheme,
      darkTheme: monochromeDarkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
