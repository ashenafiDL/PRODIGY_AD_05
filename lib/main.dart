import 'package:flutter/material.dart';
import 'package:prodigy_ad_05/home_screen.dart';
import 'package:prodigy_ad_05/util/settings/settings_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const Color _primaryColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsModel(),
      child: Consumer(
        builder: (context, SettingsModel settingsNotifier, child) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: _primaryColor,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              primaryColor: _primaryColor,
              brightness: Brightness.dark,
            ),
            themeMode:
                settingsNotifier.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
