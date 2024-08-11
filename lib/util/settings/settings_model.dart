import 'package:flutter/material.dart';
import 'package:prodigy_ad_05/util/settings/settings_preference.dart';

class SettingsModel extends ChangeNotifier {
  late Settings _preferences;

  late bool _isDark;
  late bool _keepHistory;

  bool get isDark => _isDark;
  bool get keepHistory => _keepHistory;

  SettingsModel() {
    _isDark = false;
    _keepHistory = true;
    _preferences = Settings();
    getPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  set keepHistory(bool value) {
    _keepHistory = value;
    _preferences.setHistoryPreference(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    _keepHistory = await _preferences.getHistoryPreference();
    notifyListeners();
  }
}
