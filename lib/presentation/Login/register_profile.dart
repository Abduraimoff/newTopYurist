import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/presentation/Login/confirmation_screen.dart';
import 'package:top_yurist/presentation/Login/select_region.dart';
import 'package:top_yurist/presentation/widgets/base_appbar.dart';
import 'package:top_yurist/utils/colors.dart';

class RegisterProfile extends StatefulWidget {
  static const String routeName = "register_profile";

  const RegisterProfile({Key? key}) : super(key: key);

  @override
  State<RegisterProfile> createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile> {
  String? phoneCode;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _SureNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: BaseAppBar(
        title:  LocaleText('register', style: Theme.of(context).textTheme.headline3,),
        appBar: AppBar(),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 66.h,
            ),
            CircleAvatar(
              backgroundColor: AppColors.black.withOpacity(0.06),
              radius: 40.sp,
              child: SvgPicture.asset(
                "assets/svg/frame.svg",
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            TextButton(
                onPressed: () {},
                child: LocaleText(
                  "add_photo",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: AppColors.primary),
                )),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              height: 48.h,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    hintText: context.localeString('name')),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            SizedBox(
              height: 48.h,
              child: TextField(
                controller: _SureNameController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    hintText: context.localeString('surName')),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                      text: context.localeString(
                        "registration_offer_1",
                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                      children: [
                        TextSpan(
                            text: context.localeString("registration_offer_2"),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    decoration: TextDecoration.underline)),
                      ]),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 48.h,
          width: double.infinity,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SelectRegion.routeName,
                  );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.primary,
            child: LocaleText(
              "next",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // SizedBox(
      //   width: double.infinity,
      //   child: ElevatedButton(
      //     onPressed: () {},
      //     child: LocaleText(
      //       "enter",
      //       style: Theme.of(context)
      //           .textTheme
      //           .headline3
      //           ?.copyWith(color: AppColors.white),
      //     ),
      //   ),
      // ),
    );
  }
}
