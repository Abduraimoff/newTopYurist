import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:top_yurist/presentation/Login/RegisterScreen.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';
import 'package:top_yurist/presentation/Services/SeriviceScreen.dart';
import 'package:top_yurist/presentation/chat/chat_page.dart';
import 'package:top_yurist/utils/colors.dart';

import '../LawyerFavourites/lawyerFavourites.dart';
import '../UserUploadedServices/add_new_template.dart';
import '../profile/user_profile_page.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home/screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    ServiceScreen(),

    ChatsPage(),

    LawyerFavourites(),
    UserProfilePage(),
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
