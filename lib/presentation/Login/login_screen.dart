import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
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
            DropdownButton(
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
            )
          ],
        ),
      ),
    );
  }
}
