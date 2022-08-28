import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/utils/get_current_language_content.dart';
import 'package:top_yurist/utils/icons.dart';

import '../../data/Models/multi_language_content/multi_language_content.dart';

class FaqContentPage extends StatelessWidget {
  const FaqContentPage({Key? key, required this.content}) : super(key: key);
  final MultiLanguageContent content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'faq',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                getCurrentLanguageContent(context: context, content: content),
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
      ),
    );
  }
}
