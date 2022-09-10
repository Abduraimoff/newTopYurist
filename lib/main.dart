
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/bloc/Bloc/Application/Cubit/user_offer_filter_cubit.dart';
import 'package:top_yurist/bloc/Bloc/Auth/auth_bloc.dart';
import 'package:top_yurist/bloc/Cubit/UserType/user_type_cubit.dart';
import 'package:top_yurist/bloc/profile_cubit/profile_cubit.dart';
import 'package:top_yurist/presentation/Home/home_screen.dart';
import 'package:top_yurist/presentation/Login/RegisterScreen.dart';
import 'package:top_yurist/presentation/Login/confirmation_screen.dart';
import 'package:top_yurist/presentation/Login/lawyer_select_category.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';
import 'package:top_yurist/presentation/Login/register_profile.dart';
import 'package:top_yurist/presentation/Login/select_region.dart';
import 'package:top_yurist/presentation/Services/select_category.dart';
import 'package:top_yurist/presentation/Services/service_detail.dart';
import 'package:top_yurist/presentation/User/Home/home_screen_user.dart';
import 'package:top_yurist/presentation/User/Home/widgets/user_filter_offer.dart';
import 'package:top_yurist/presentation/User/Requests/create_new_request.dart';
import 'package:top_yurist/presentation/User/Requests/lawyer_profile_screen.dart';
import 'package:top_yurist/presentation/User/Requests/request_detail.dart';
import 'package:top_yurist/presentation/UserUploadedServices/LawyerChatScreen.dart';
import 'package:top_yurist/presentation/UserUploadedServices/chat_screen.dart';
import 'package:top_yurist/presentation/UserUploadedServices/create_new_template.dart';
import 'package:top_yurist/presentation/UserUploadedServices/create_template.dart';
import 'package:top_yurist/presentation/UserUploadedServices/filter_by_city.dart';
import 'package:top_yurist/presentation/UserUploadedServices/uploaded_service_detail.dart';
import 'package:top_yurist/utils/config.dart';
import 'package:top_yurist/utils/theme.dart';

import 'bloc/Cubit/Auth/auth_user_cubit.dart';

void main() async {
  const storage = FlutterSecureStorage();

  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init([
    'ru',
    "en",
    "uz",
  ]);
  final String? userType = await storage.read(key: Config.userType);
  Widget defaultHomeScreen = const LoginScreen();
    if(await storage.read(key: Config.accessToken) !=  null){
      defaultHomeScreen =   HomeScreen(userType: userType,);
    }


  runApp(MyApp(
    defaultHome: defaultHomeScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? defaultHome;
  const MyApp({Key? key, this.defaultHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) => AuthUserCubit(), lazy: false),
          BlocProvider(create: (context) => UserOfferFilterCubit(), lazy: false),
          BlocProvider(create: (context) => UserTypeCubit()),
        ],
        child: BlocBuilder<UserTypeCubit, UserTypeState>(
  builder: (context, state) {
    if(state is UserTypeChanged){}
    return LocaleBuilder(
            builder: (locale) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Top Yurist',
                  localizationsDelegates: Locales.delegates,
                  supportedLocales: Locales.supportedLocales,
                  locale: locale,
                  theme: MainTheme().themeData,
                  home: defaultHome,
                  routes: {
                    HomeScreenUser.routeName: (context) =>
                        const HomeScreenUser(),
                    RegisterScreen.registerScreen: (context) =>
                        BlocProvider<AuthBloc>(
                          create: (
                            context
                          ) =>
                              AuthBloc(),
                          child: const RegisterScreen(),
                        ),
                    ConfirmationScreen.routeName: (context) =>
                        const ConfirmationScreen(),
                    RegisterProfile.routeName: (context) =>
                        const RegisterProfile(),
                    SelectRegion.routeName: (context) => const SelectRegion(),
                    SelectCategory.routeName: (context) =>
                        const SelectCategory(),
                    ServiceDetail.routeName: (context) => const ServiceDetail(),
                    CreateNewRequest.routeName: (context) =>
                        const CreateNewRequest(),
                    UserRequestDetail.routeName: (context) =>
                        const UserRequestDetail(),
                    LoginScreen.routeName: (context) => const LoginScreen(),
                    LawyerSelectCategory.routeName: (context) =>
                        const LawyerSelectCategory(),
                    HomeScreen.routeName: (context) => const HomeScreen(),
                    UserProfileScreen.routeName: (context) =>
                        const UserProfileScreen(),
                    LawyerChatScreen.routeName: (context) =>
                        const LawyerChatScreen(),
                    FilterByCity.routeName: (context) => const FilterByCity(),
                    UploadedServiceDetail.routeName: (context) =>
                         const UploadedServiceDetail(),
                    CreateTemplateScreen.routeName: (context) =>
                        const CreateTemplateScreen(),
                    ChatScreen.routeName: (context) => const ChatScreen(),
                    UserFilterOffer.routeName: (context) => const UserFilterOffer(),
                    CreateNewTemplate.routeName:(context) => const CreateNewTemplate()
                  },
                ));
  },
));
  }
}
