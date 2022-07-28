import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';
import 'package:top_yurist/utils/colors.dart';

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
        supportedLocales: const [
          Locale.fromSubtags(languageCode: "ru"),
          Locale.fromSubtags(languageCode: "en"),
          Locale.fromSubtags(languageCode: 'uz', scriptCode: "Latn"),
          Locale.fromSubtags(languageCode: "uz", scriptCode: "Cyrl")
        ],
        locale: locale,
        theme: ThemeData(
            fontFamily: "Aeroport",
            primarySwatch: Colors.blue,
            textTheme:  TextTheme(
              headline2: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.black),
              headline3: const TextStyle(fontSize: 16, color: AppColors.black, fontWeight: FontWeight.w500),
              button: TextStyle(fontSize: 16, color: AppColors.black.withOpacity(0.4), fontWeight: FontWeight.w400)
            ),
            scaffoldBackgroundColor: AppColors.scaffoldBackground),
        home: const LoginScreen(),
      ),
    );
  }
}
