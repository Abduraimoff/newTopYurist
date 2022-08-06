import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

abstract class TextFieldDecorations {
  static InputDecoration roundedDecoration(BuildContext context) {
    return InputDecoration(
      hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      isCollapsed: true,
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(133, 141, 163, 1)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.blue),
      ),
    );
  }
}
