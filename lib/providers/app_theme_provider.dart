import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  AppThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('appTheme');
    appTheme = (theme == "dark") ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (newTheme == appTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('appTheme', newTheme == ThemeMode.dark ? "dark" : "light");
  }
}

