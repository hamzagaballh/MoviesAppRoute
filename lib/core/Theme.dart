import 'package:flutter/material.dart';
import 'package:movie_app/core/Colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.secondary,
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          color: AppColors.gold,
        ),
        selectedIconTheme: IconThemeData(color: AppColors.gold, size: 35),
        selectedItemColor: AppColors.gold,
        unselectedLabelStyle: TextStyle(
          color: AppColors.third,
        ),
        unselectedIconTheme: IconThemeData(color: AppColors.third, size: 30),
        unselectedItemColor: AppColors.third),
    textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(
            fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        titleSmall: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
        bodyMedium: TextStyle(
            fontSize: 15, color: Colors.white, fontWeight: FontWeight.w100),
        bodySmall: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
  );
}
