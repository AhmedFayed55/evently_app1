import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  changeTheme(ThemeMode newTheme) {
    if (newTheme == appTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }
}
