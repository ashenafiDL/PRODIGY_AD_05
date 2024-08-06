import 'package:flutter/material.dart';
import 'package:prodigy_ad_05/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const Color _primaryColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: _primaryColor,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primaryColor: _primaryColor,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
