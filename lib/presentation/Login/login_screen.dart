import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120.h,
            ),
            Center(child: Image.asset("assets/images/Logo.png")),
            SizedBox(
              height: 63.h,
            ),
            LocaleText(
              "welcome",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 37.h,
            ),
            Container(
              color: AppColors.scaffoldBackground,
              child: DropdownButton(

                icon:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SvgPicture.asset('assets/svg/icon_arrow-right.svg'),
                ),
                style: Theme.of(context).textTheme.button,
              underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(
                    value: "ru",
                    child: Text('Русский'),
                  ),
                  DropdownMenuItem(
                    value: "uz",
                    child: Text('O\'zbek'),
                  ),
                  DropdownMenuItem(
                    value: "uzc",
                    child: Text('Узбек'),
                  ),
                  DropdownMenuItem(
                    value: "en",
                    child: Text('English'),
                  ),
                ],
                onChanged: (String? v) {

                  Locales.change(context, v ?? "ru" );
                },
                onTap: () {},
                value: Locales.lang,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 48.h,
              width: 343.w,
              child: ElevatedButton(
                  onPressed: (){},  style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(133, 141, 163, 0.1), elevation: 0, ),child:  LocaleText("i_lawyer", style: Theme.of(context).textTheme.headline3,),),
            ),
            SizedBox(height: 21.h,),
            SizedBox(
                height: 48.h,
                width: 343.w,
                child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(133, 141, 163, 0.1), elevation: 0, ), child:  LocaleText("i_user", style: Theme.of(context).textTheme.headline3,))),
            SizedBox(height: 30.h,)
          ],
        ),
      ),
    );
  }
}
