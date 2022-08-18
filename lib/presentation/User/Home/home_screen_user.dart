import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:top_yurist/presentation/profile/profile_page.dart';
import 'package:top_yurist/utils/colors.dart';

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
    CreateRequestScreen(),
    ChatsPage(),
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
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: context.localeString("services"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: context.localeString("chats"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: context.localeString("favourites"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: context.localeString("setting"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        unselectedLabelStyle: const TextStyle(
            fontSize: 12, color: AppColors.grey, fontWeight: FontWeight.w400),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
