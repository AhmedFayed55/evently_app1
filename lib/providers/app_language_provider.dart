import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = "en";

  AppLanguageProvider() {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString('appLanguage') ?? "en";
    notifyListeners();
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (newLanguage == appLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('appLanguage', newLanguage);
  }
}
