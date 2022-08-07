import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/utils/colors.dart';

class FilterByCity extends StatelessWidget {
  static const routeName = "filter/by/city";
  const FilterByCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.grey),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Фильтр по городам',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 2.4,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(itemBuilder: (context, i){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              SizedBox(height: 16.h,),
              Text('город Ташкент'),
              SizedBox(height: 16),
              Divider(color: AppColors.grey, height: 1.h,),
            ],
          );
        }, itemCount: 4,)
      ),
    );
  }
}
