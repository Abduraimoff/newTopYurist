import 'package:flutter/material.dart';

import 'colors.dart';

class MainTheme {
  ThemeData themeData = ThemeData(
      fontFamily: "Aeroport",
      primarySwatch: Colors.blue,
      textTheme:  TextTheme(
          headline2:  const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: AppColors.black),
          headline3:  const TextStyle(fontSize: 16, color: AppColors.black, fontWeight: FontWeight.w500),
            headline5: const TextStyle(fontSize: 12, color: AppColors.grey, fontWeight: FontWeight.w400),
          bodyText1: TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.5), fontWeight: FontWeight.w400),
          button: TextStyle(fontSize: 16, color: AppColors.black.withOpacity(0.4), fontWeight: FontWeight.w400),
          // bodyMedium: TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.5), fontWeight: FontWeight.w400)
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackground);
}