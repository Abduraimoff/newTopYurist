import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


class ServiceList extends StatelessWidget {
  const ServiceList({Key? key}) : super(key: key);

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
              SizedBox(height: 20.h),
              Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 32.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16.h,
                                        backgroundImage: AssetImage("assets/images/lowyer.jpg"),
                                        onBackgroundImageError: (exception, stackTrace) =>
                                        const AssetImage('assets/images/userError.png'),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Альбина Юлдашева",
                                        style: TextStyle(
                                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  SvgPicture.asset("assets/svg/trash.svg"),
                                ],
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Нужна консультация юриста по уголовному праву. Цену можем обговорить лично приме...",
                              style: TextStyle(
                                color: const Color(0xFF858DA3),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10.h),

                            const Divider(),

                          ],
                        ),

                      );;
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
