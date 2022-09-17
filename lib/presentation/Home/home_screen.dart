import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/bloc/Cubit/UserType/user_type_cubit.dart';
import 'package:top_yurist/bloc/Cubit/UserType/user_type_cubit.dart';
import 'package:top_yurist/presentation/Services/SeriviceScreen.dart';
import 'package:top_yurist/presentation/chat/chat_page.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../utils/bottom_nav_bar_icons.dart';
import '../LawyerFavourites/lawyerFavourites.dart';
import '../User/Favourites/favourites_screen.dart';
import '../User/Requests/request_screen.dart';
import '../profile/profile_page.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home/screen";
  final String? userType;

  const HomeScreen({Key? key, this.userType}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const ServiceScreen(),
    const ChatsPage(),
    const LawyerFavourites(),
    const UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    context.read<UserTypeCubit>().changeType(widget.userType);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: BlocBuilder<UserTypeCubit, UserTypeState>(
        builder: (context, state) {
          if (state is UserTypeChanged) {
            return Center(
              child: <Widget>[
                state.userType == "lawyer"
                    ? const ServiceScreen()
                    : const CreateRequestScreen(),
                const ChatsPage(),
                state.userType == "lawyer"
                    ? const LawyerFavourites()
                    : const FavouritesScreen(),
                const UserProfilePage(),
              ].elementAt(_selectedIndex),
            );
          }
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 50.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            bottomIcons.length,
            (index) {
              return Container(
                width: 75.w,
                height: 50.h,
                padding: EdgeInsets.only(top: 5.h),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _onItemTapped(index);
                      },
                      child: SvgPicture.asset(
                        _selectedIndex == index
                            ? bottomIcons[index]['active']
                            : bottomIcons[index]['inactive'],
                        width: 24.w,
                        height: 24.h,
                        color: _selectedIndex != index
                            ? AppColors.grey
                            : AppColors.primary,
                      ),
                    ),
                    Text(
                      bottomIcons[index]['title'],
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: _selectedIndex != index
                                ? AppColors.grey
                                : AppColors.primary,
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
