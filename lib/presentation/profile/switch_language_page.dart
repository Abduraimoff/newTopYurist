import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';

class SwitchLanguagePage extends StatefulWidget {
  const SwitchLanguagePage({Key? key}) : super(key: key);

  @override
  State<SwitchLanguagePage> createState() => _SwitchLanguagePageState();
}

class _SwitchLanguagePageState extends State<SwitchLanguagePage> {
  @override
  Widget build(BuildContext context) {
    Widget languageItem({
      required String text,
      required String languageCode,
    }) {
      final isSelected = Locales.lang == languageCode;
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                Container(
                  height: 20.h,
                  width: 20.h,
                  padding: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.blue
                        : AppColors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: isSelected
                      ? const FittedBox(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )
                      : null,
                )
              ],
            ),
          ),
          Positioned.fill(
              child: Material(
            color: Colors.transparent,
            child: InkWell(onTap: () {
              setState(() {
                Locales.change(context, languageCode);
              });
            }),
          ))
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      AppIcons.chevronLeft,
                      height: 24.h,
                      width: 24.h,
                    ),
                  ),
                  LocaleText(
                    'switch_language',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 16.h),
              languageItem(text: 'Русский язык', languageCode: 'ru'),
              languageItem(text: 'English language', languageCode: 'en'),
              languageItem(
                text: 'O\'zbek tili',
                languageCode: 'uz',
              ),
              languageItem(
                text: 'Ўзбек тили',
                languageCode: 'uz',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
