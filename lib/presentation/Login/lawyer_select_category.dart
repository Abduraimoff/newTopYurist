
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/presentation/Home/home_screen.dart';
import 'package:top_yurist/presentation/widgets/base_appbar.dart';

import '../../utils/colors.dart';

class LawyerSelectCategory extends StatefulWidget {
  static const String routeName = "lawyer/select/category";
  const LawyerSelectCategory({Key? key}) : super(key: key);

  @override
  State<LawyerSelectCategory> createState() => _LawyerSelectCategoryState();
}

class _LawyerSelectCategoryState extends State<LawyerSelectCategory> {
  final List<String> added = [];
  static const List<String> categories = [
    "Уголовное право",
    "Экономическое право",
    "Гражданское право",
    "Джизакская область",
    "Административное право",
    "Вопросы с БПИ",
    "Консультант (по налогам)",
    "Консультант (по растаможке)",
    "Консультант (другие вопросы)",
    "Нотариус",
    "Медиатор"
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), title: Text("Выберите свою категорию", style: Theme.of(context).textTheme.headline3,),),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(itemBuilder: (context, i){
            return ListTile(leading: Container(height: 18.h, width: 18.h,
                decoration:  BoxDecoration(shape: BoxShape.circle, color: added.contains(categories[i]) ?  AppColors.primary : AppColors.grey),
                  child: added.contains(categories[i]) ?  const Center(child: Icon(Icons.check, size: 10, color: Colors.white,),) : null,
                ),
            title: Text(categories[i]),
              onTap: (){
              added.add(categories[i]);
              setState(() {

              });
              },
            );
          },
          itemCount: categories.length,
          ),
        ),
        Container(
          height: 48.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.sp)),
            width: double.infinity,
            child: ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
            },
              style: ElevatedButton.styleFrom(primary: AppColors.primary),
              child: LocaleText('save', style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.white),), )),
        SizedBox(height: 40.h,)
      ],
    ),
    );
  }
}
