import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Cubit/CheckUserRole/user_role_cubit.dart';
import 'package:top_yurist/presentation/Login/lawyer_select_category.dart';
import 'package:top_yurist/presentation/User/Home/home_screen_user.dart';
import 'package:top_yurist/presentation/widgets/base_appbar.dart';
import 'package:top_yurist/utils/colors.dart';

class SelectRegion extends StatefulWidget {
  static const routeName = "Select-region";
   const SelectRegion({Key? key}) : super(key: key);
static const List<String> regions = [
  "город Ташкент",
  "Андижанская область",
  "Бухарская область",
  "Джизакская область",
  "Навоийская область",
  "Самаркандская область",
  "Ташкентская область",
  "Ферганская область",
  "Хорезмская область",
  "Республика Каракалпакстан"
];

  @override
  State<SelectRegion> createState() => _SelectRegionState();
}

class _SelectRegionState extends State<SelectRegion> {
final List<String> added = [];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), title: LocaleText("select_region_title", style: Theme.of(context).textTheme.headline3,),),
      body: Padding(
        padding:  EdgeInsets.only(left: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: SelectRegion.regions.map((e) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h,),
          InkWell(
            onTap: (){
              if(context.read<UserRoleCubit>().userStatus == "user"){
                Navigator.of(context).pushNamedAndRemoveUntil(HomeScreenUser.routeName, (route) => false);
              }else{
                Navigator.of(context).pushNamed(LawyerSelectCategory.routeName);
              }
              
              added.add(e);
              setState(() {

              });
            },
            child: Row(
              children: [
                // Container(height: 18.h, width: 18.h,
                // decoration:  BoxDecoration(shape: BoxShape.circle, color: added.contains(e) ?  AppColors.primary : AppColors.grey),
                //   child: added.contains(e) ?  const Center(child: Icon(Icons.check, size: 10, color: Colors.white,),) : null,
                // ),
                SizedBox(width: 9.w,),
                Text(e, style: Theme.of(context).textTheme.headline3,),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          const Divider(color: AppColors.grey,),
        ],)).toList(),),
      ),);
  }
}
