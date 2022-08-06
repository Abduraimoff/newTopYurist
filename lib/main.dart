import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/profile_cubit/profile_cubit_cubit.dart';
import 'package:top_yurist/data/Models/user/user.dart';
import 'package:top_yurist/presentation/Home/home_screen.dart';
import 'package:top_yurist/presentation/Services/select_category.dart';
import 'package:top_yurist/presentation/Login/RegisterScreen.dart';
import 'package:top_yurist/presentation/Login/confirmation_screen.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';
import 'package:top_yurist/presentation/Login/register_profile.dart';
import 'package:top_yurist/presentation/Login/select_region.dart';
import 'package:top_yurist/presentation/Services/service_detail.dart';
import 'package:top_yurist/presentation/User/Home/home_screen_user.dart';
import 'package:top_yurist/presentation/User/Requests/create_new_request.dart';
import 'package:top_yurist/presentation/User/Requests/request_detail.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/theme.dart';

import 'presentation/profile/user_profile_page.dart';

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
                isVerified: false,
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
                  debugShowCheckedModeBanner: false,
                  title: 'Top Yurist',
                  localizationsDelegates: Locales.delegates,
                  supportedLocales: Locales.supportedLocales,
                  locale: locale,
                  theme: MainTheme().themeData,
                  home: const HomeScreen(),
                  routes: {
                    RegisterScreen.registerScreen: (context) =>
                        const RegisterScreen(),
                    ConfirmationScreen.routeName: (context) => const ConfirmationScreen(),
                    RegisterProfile.routeName: (context) => const RegisterProfile(),
                    SelectRegion.routeName: (context) =>  const SelectRegion(),
                    SelectCategory.routeName: (context) => const SelectCategory(),
                    ServiceDetail.routeName: (context) => const ServiceDetail(),
                    CreateNewRequest.routeName:(context) => const CreateNewRequest(),
                    UserRequestDetail.routeName:(context) => const UserRequestDetail()
                  },
                )));
  }
}
