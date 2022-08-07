import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/presentation/widgets/base_appbar.dart';
import 'package:top_yurist/utils/colors.dart';

import 'ServiceList/ServiceList.dart';

class ServiceDetail extends StatelessWidget {
  static const String routeName = 'service-detail';

  const ServiceDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: BaseAppBar(
          appBar: AppBar(),
          centerTitle: true,
          title: Text(
            'Уголовное дело',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: Column(
          children: [
            TabBar(
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), // Creates border
                    color: AppColors.white.withAlpha(0)),
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.blue,
                tabs: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 40.0,
                    alignment: Alignment.center,
                    child: Text("Новые"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    height: 40.0,
                    child: Center(child: Text("Выбранные")),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    height: 40.0,
                    child: Text("Отказы"),
                  )
                ]),
            const Expanded(
                child: TabBarView(
              children: [
                ServiceList(),
                ServiceList(),
                ServiceList(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
