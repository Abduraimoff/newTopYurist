import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/presentation/widgets/base_appbar.dart';

import '../../utils/colors.dart';

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
        body: Column(children: [
          TabBar(
            indicatorColor:  AppColors.primary ,
              automaticIndicatorColorAdjustment: true,
              indicatorPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              tabs: [
           Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(56.sp),
           ),
             child: Text("heelo")
             ,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(56.sp),
                  color: AppColors.grey

                ),
                  child: Center(child: Text("heelo"))
                  ,),
                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(56.sp),
                ),
                  child: Text("heelo")
                  ,)

          ]),
          Expanded(child: TabBarView(children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],))
        ],),

      ),
    );
  }
}
