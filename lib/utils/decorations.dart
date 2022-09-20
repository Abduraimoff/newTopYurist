import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

abstract class TextFieldDecorations {
  static InputDecoration roundedDecoration(BuildContext context) {
    return InputDecoration(
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF18181C).withOpacity(0.5),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      isCollapsed: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(
            color: const Color(0xFF858DA3).withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(8.h),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: Color.fromRGBO(133, 141, 163, 1), width: 1),
        borderRadius: BorderRadius.circular(8.h),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.blue),
        borderRadius: BorderRadius.circular(8.h),
      ),
      hintMaxLines: 3,
    );
  }
}
