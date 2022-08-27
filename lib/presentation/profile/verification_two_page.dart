import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_yurist/presentation/profile/verification_page.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/get_image.dart';
import 'package:top_yurist/utils/icons.dart';

class VerificationTwoPage extends StatefulWidget {
  const VerificationTwoPage({Key? key}) : super(key: key);

  @override
  State<VerificationTwoPage> createState() => _VerificationTwoPageState();
}

class _VerificationTwoPageState extends State<VerificationTwoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const _AppBarWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h),
                      const _InformationWidget(),
                      SizedBox(height: 25.h),
                      const _PassportWidget(),
                      SizedBox(height: 28.h),
                      const _DiplomWidget(),
                      SizedBox(height: 28.h),
                      const _LicenseWidget(),
                      SizedBox(height: 28.h),
                      const _ExtractWidget(),
                      SizedBox(height: 28.h),
                      const _StateLicenseWidget(),
                      SizedBox(height: 30.h),
                      const _AgreementsWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InformationWidget extends StatelessWidget {
  const _InformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.6.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(133, 141, 163, 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Данная информация не будет отображаться в вашем профиле. Ваши данные будут проверенны администрацией.',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF858DA3),
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verificationFirstState =
        context.findAncestorStateOfType<VerificationPageState>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            verificationFirstState?.changePage(1);
          },
          child: SvgPicture.asset(
            AppIcons.chevronLeft,
            height: 24.h,
            width: 24.h,
          ),
        ),
        Column(
          children: [
            LocaleText(
              'verification',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              '2/2',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox.shrink(),
      ],
    );
  }
}

class _PassportWidget extends StatelessWidget {
  const _PassportWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Парспорт',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(28, 79, 209, 0.1),
            child: Text(
              'Добавьте лицевую сторону',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
            onPressed: () async {
              final file = await pickImage();
            },
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(28, 79, 209, 0.1),
            child: Text(
              'Добавьте лицевую сторону',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
            onPressed: () async {
              final file = await pickImage();
            },
          ),
        ),
      ],
    );
  }
}

class _DiplomWidget extends StatelessWidget {
  const _DiplomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Диплом',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(28, 79, 209, 0.1),
            child: Text(
              'Добавьте фото диплома',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
            onPressed: () async {
              final file = await pickImage();
            },
          ),
        ),
      ],
    );
  }
}

class _LicenseWidget extends StatelessWidget {
  const _LicenseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Лицензия',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(28, 79, 209, 0.1),
            child: Text(
              'Добавьте фото лицензии',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
            onPressed: () async {
              final file = await pickImage();
            },
          ),
        ),
      ],
    );
  }
}

class _ExtractWidget extends StatelessWidget {
  const _ExtractWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Выписка',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(28, 79, 209, 0.1),
            child: Text(
              'Добавьте фото лицензии',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
            onPressed: () async {
              final file = await pickImage();
            },
          ),
        ),
      ],
    );
  }
}

class _StateLicenseWidget extends StatelessWidget {
  const _StateLicenseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Государственную лицензию',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(28, 79, 209, 0.1),
            onPressed: () async {
              final file = await pickImage();
            },
            child: Text(
              'Добавьте фото лицензии',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AgreementsWidget extends StatefulWidget {
  const _AgreementsWidget({Key? key}) : super(key: key);

  @override
  State<_AgreementsWidget> createState() => _AgreementsWidgetState();
}

class _AgreementsWidgetState extends State<_AgreementsWidget> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              child: Checkbox(
                activeColor: AppColors.blue,
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = value ?? false;
                  });
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Согласен на сбор, обработку персональных данных',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF858DA3),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 13.h),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            borderRadius: BorderRadius.circular(8),
            color: isActive
                ? AppColors.blue
                : const Color.fromRGBO(28, 79, 209, 0.1),
            onPressed: isActive ? () {} : null,
            child: Text(
              'Пройти верификацию',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: isActive ? Colors.white : AppColors.blue,
              ),
            ),
          ),
        )
      ],
    );
  }
}
