import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class MainTheme {
  ThemeData getTheme(BuildContext context) {
    ThemeData themeData = ThemeData(
      fontFamily: "Aeroport",
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        headline2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
            color: AppColors.black),
        headline3: TextStyle(
            fontSize: 16.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500),
        button: TextStyle(
            fontSize: 16.sp,
            color: AppColors.black.withOpacity(0.4),
            fontWeight: FontWeight.w400),
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
    );

    return themeData;
  }
}
