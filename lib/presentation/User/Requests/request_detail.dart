import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class UserRequestDetail extends StatelessWidget {
  static const String routeName = "user-request-detail";
  const UserRequestDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Уголовное дело',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 2.4,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.filter_list_rounded, color: Colors.black),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            TabBar(
              // indicatorPadding:
              // const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color:  AppColors.primary,
                borderRadius: BorderRadius.circular(58.sp),
              ),
              tabs: const [
                Tab(text: 'Все'),
                Tab(text: 'Выбранные'),
                Tab(text: 'Запрос зыкрыт'),
              ],
            ),

            Expanded(
              child: TabBarView(children: [
                DefaultTabView(),
                DefaultTabView(),
                DefaultTabView(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultTabView extends StatelessWidget {
  const DefaultTabView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i){
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp)),
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/Ellipse64.png')),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Феруз Тахирович',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Верифицирован',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.favorite_outline, color: Colors.grey)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 23,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C4FD1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(58),
                    ),
                    child: const Center(
                      child: Text(
                        'Выбран вами',
                        style: TextStyle(color: Color(0xFF1C4FD1)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }, itemCount: 4,);
  }
}
