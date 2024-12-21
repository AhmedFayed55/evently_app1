import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryLight,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryLight),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: true, elevation: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryLight,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: AppColors.white, width: 5))));
  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryDark,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryDark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: true, elevation: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDark,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: AppColors.white, width: 5))));
}
