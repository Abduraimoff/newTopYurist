import 'package:flutter/material.dart';

import 'package:top_yurist/utils/colors.dart';

class MessageOption {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  MessageOption({
    required this.text,
    required this.onTap,
    this.backgroundColor = AppColors.blue,
    this.textColor = AppColors.white,
  });

  MessageOption copyWith({
    String? text,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return MessageOption(
      text: text ?? this.text,
      onTap: onTap ?? this.onTap,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
