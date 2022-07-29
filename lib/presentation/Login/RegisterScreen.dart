import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class RegisterScreen extends StatelessWidget {
  static const String registerScreen = "register_screen";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 134.h,),
               LocaleText("register", style: Theme.of(context).textTheme.headline2,),
              SizedBox(height: 8.h,),
              const LocaleText('type_your_number'),
              SizedBox(height: 32.h,),
              Row(children: [
                Container(child: Row(children: [
                  Text("+998", )
                ],),)
              ],)


            ],
          ),
        ),
      ),
    );
  }
}
