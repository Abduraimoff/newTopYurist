import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/presentation/widgets/base_appbar.dart';

import '../../utils/colors.dart';

class SelectCategory extends StatelessWidget {
  static const String routeName = "select_category";
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), title: Text('Выберите свою категорию',
          style: Theme.of(context).textTheme.headline3,),),

      body: Padding(
        padding:  EdgeInsets.only(left: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, i){
                  return Column(children: [
                    SizedBox(height: 16.h,),
                    Row(
                      children: [
                        Container(
                          height: 19.h,
                          width: 19.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child:  Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 9.w),
                         Text('Вопросы с БПИ', style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.darkBlack, fontWeight: FontWeight.w400),)
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Divider(color: Colors.grey),
                    ),
                  ],);
                })),
            Container(
              width: double.infinity,
              height: 46,
              margin: EdgeInsets.only(right: 16.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF1C4FD1)),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Сохранить',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 40.h,),
          ],
        ),
      ),
    );
  }
}
