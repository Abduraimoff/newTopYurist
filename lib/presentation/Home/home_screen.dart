import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:top_yurist/bloc/Cubit/UserType/user_type_cubit.dart';
import 'package:top_yurist/bloc/Cubit/UserType/user_type_cubit.dart';
import 'package:top_yurist/presentation/Services/SeriviceScreen.dart';
import 'package:top_yurist/presentation/chat/chat_page.dart';
import 'package:top_yurist/utils/colors.dart';

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
    return Scaffold(
      body: BlocBuilder<UserTypeCubit, UserTypeState>(
        builder: (context, state) {
          if(state is UserTypeChanged){
            return Center(
              child: <Widget>[
              state.userType == "lawyer" ?  const ServiceScreen() :   const CreateRequestScreen(),
                const ChatsPage(),
                state.userType == "lawyer" ?   const LawyerFavourites() :    const FavouritesScreen(),
                const UserProfilePage(),
              ].elementAt(_selectedIndex),
            );
          }
          return const Center(child: CupertinoActivityIndicator());
        },
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
