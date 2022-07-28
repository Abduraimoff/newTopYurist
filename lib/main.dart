import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:top_yurist/bloc/cubit/profile_cubit_cubit.dart';
import 'package:top_yurist/data/Models/user/user.dart';
import 'package:top_yurist/presentation/lawyer_profile_page/lawyer_profile_page.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(
            User(
              name: 'Феруз Тахирович',
              phoneNumber: '+998999999999',
              image: 'assets/images/lawyer.jpg',
              isVerified: true,
              type: UserType.lawyer,
              amountFavorites: 4,
              amountSelects: 5,
              amountCOmplates: 6,
            ),
          ),
        )
      ],
      child: LocaleBuilder(
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
      ),
    );
  }
}
