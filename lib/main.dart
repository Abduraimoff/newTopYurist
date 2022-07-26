import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['ru']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(builder: (locale) =>
        ScreenUtilInit(
            designSize: const Size(375, 835),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child){
          return MaterialApp(
            title: 'Top Yurist',
            localizationsDelegates: Locales.delegates,
            supportedLocales: Locales.supportedLocales,
            locale: locale,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: (ctx, child){
              ScreenUtil.init(ctx);
              return const LoginScreen();
            },

          );
        })
    );
  }
}
