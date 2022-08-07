import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/presentation/Services/select_category.dart';
import 'package:top_yurist/presentation/Services/service_detail.dart';
import 'package:top_yurist/utils/colors.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                'Услуги',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                height: 46.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primary.withOpacity(0.1)),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SelectCategory.routeName);
                  },
                  child: const Text(
                    'Выбрать категорию',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Expanded(
                  child: ListView.builder(

                itemBuilder: (context, i) {

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ServiceDetail.routeName);
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      // shadowColor: AppColors.shadow,

                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),

                      ),
                      color: AppColors.white,
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Уголовное право',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        SizedBox(width: 6.w),
                                        Container(
                                          width: 16.w,
                                          height: 16.h,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.h),
                                    Text(
                                      'Количество запросов: 56',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ],
                                ),
                                SvgPicture.asset("assets/svg/trash.svg"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 4,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
