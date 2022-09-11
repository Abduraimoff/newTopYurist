
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/presentation/Login/RegisterScreen.dart';
import 'package:top_yurist/utils/colors.dart';
import '../../bloc/Cubit/Auth/auth_user_cubit.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login/screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: AppColors.scaffoldBackground,),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80.h,
            ),
            Center(child: SvgPicture.asset('assets/icons/logo_new.svg')),
            SizedBox(
              height: 10.h,
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
                icon: Padding(
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
                  Locales.change(context, v ?? "ru");
                },
                onTap: () {},
                value: Locales.lang,
              ),
            ),
            Image.asset(
              "assets/images/Безымянный-1.png",
              width: 247.w,
              height: 247.h,
            ),
            const Spacer(),
            SizedBox(
              height: 48.h,
              width: 343.w,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RegisterScreen.registerScreen);
                  context.read<AuthUserCubit>().getUserType("lawyer");
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(133, 141, 163, 0.1),
                  elevation: 0,
                ),
                child: LocaleText(
                  "i_lawyer",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            SizedBox(
                height: 48.h,
                width: 343.w,
                child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthUserCubit>().getUserType("customer");
                      Navigator.of(context)
                          .pushNamed(RegisterScreen.registerScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(133, 141, 163, 0.1),
                      elevation: 0,
                    ),
                    child: LocaleText(
                      "i_user",
                      style: Theme.of(context).textTheme.headline3,
                    ))),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }
}
