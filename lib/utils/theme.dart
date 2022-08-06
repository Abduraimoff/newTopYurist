import 'package:flutter/material.dart';

import 'colors.dart';

class MainTheme {
  ThemeData themeData = ThemeData(
      fontFamily: "Aeroport",
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
          headline2: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: AppColors.black),
          headline3: const TextStyle(
              fontSize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.w500),
          bodyText1: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.black.withOpacity(0.5)),
          headline5: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.grey, ),
          button: TextStyle(
              fontSize: 16,
              color: AppColors.black.withOpacity(0.4),
              fontWeight: FontWeight.w400)),
          tabBarTheme: TabBarTheme(
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: AppColors.black,

            indicator: BoxDecoration(borderRadius: BorderRadius.circular(52), color: AppColors.primary),),
      scaffoldBackgroundColor: AppColors.scaffoldBackground);
}
