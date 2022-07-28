import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';
import 'package:top_yurist/presentation/lawyer_profile_page/lawyer_profile_page.dart';
import 'package:top_yurist/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init([
    'ru',
    "en",
    "uz",
  ]);
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        title: 'Top Yurist',
        localizationsDelegates: Locales.delegates,
        supportedLocales: [
          Locale.fromSubtags(languageCode: "ru"),
          Locale.fromSubtags(languageCode: "en"),
          Locale.fromSubtags(languageCode: 'uz', scriptCode: "Latn"),
          Locale.fromSubtags(languageCode: "uz", scriptCode: "Cyrl")
        ],
        locale: locale,
        theme: ThemeData(
          fontFamily: "Aeroport",
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            headline2: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColors.black),
          ),
        ),
        home: LawyerProfilePage(),
      ),
    );
  }
}
