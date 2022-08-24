import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:top_yurist/utils/colors.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final bool? isLoading;

  const BaseButton(
      {Key? key, required this.title, required this.onPressed, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(primary: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: (isLoading ?? false)
          ? const Center(child: CupertinoActivityIndicator())
          : LocaleText(title!, style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.white),),
    );
  }
}
