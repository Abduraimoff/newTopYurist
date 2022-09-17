import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/presentation/profile/profile_page.dart';
import 'package:top_yurist/utils/colors.dart';
import '../../../utils/bottom_nav_bar_icons.dart';
import '../../chat/chat_page.dart';
import '../Favourites/favourites_screen.dart';
import '../Requests/request_screen.dart';

class HomeScreenUser extends StatefulWidget {
  static const String routeName = "home/screen/user";
  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const CreateRequestScreen(),
    const ChatsPage(),
    const FavouritesScreen(),
    const UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
