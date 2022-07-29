import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/presentation/Login/RegisterScreen.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init([
    'ru',
    "en",
    "uz",
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        title: 'Top Yurist',
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        theme: MainTheme().themeData,
        home: const LoginScreen(),
        routes: {
          RegisterScreen.registerScreen: (context)=> const RegisterScreen(),
        },
      ),
    );
  }
}
