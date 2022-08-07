

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/presentation/User/Requests/create_new_request.dart';
import 'package:top_yurist/presentation/User/Requests/request_detail.dart';
import 'package:top_yurist/utils/colors.dart';

class RequestMainScreen extends StatelessWidget {
  const RequestMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Запросы',
            style: Theme.of(context).textTheme.headline2?.copyWith(fontWeight: FontWeight.bold),
          ),
           SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            height: 46.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              color:  AppColors.primary.withOpacity(0.10),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CreateNewRequest.routeName);
              },
              child:  Text(
                'Создать запрос',
                style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.primary ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 12.h),
              itemBuilder: (context, i){
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp)),
                child: Container(
                  padding:  EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(UserRequestDetail.routeName);
                            },
                            child: Row(
                              children: [
                                const Text(
                                  'Уголовное право',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                 SizedBox(width: 12.w),
                                Padding(
                                  padding:  EdgeInsets.only(bottom: 5.h),
                                  child: Container(
                                    width: 16.w,
                                    height: 16.h,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF1C4FD1),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '1',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.more_horiz, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 4),
                       Text(
                        'Нужна консультация юриста по уголовному праву. Цену можем обговорить лично, примерную стоимость за консультицию и защиту по делу в суде',
                        style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.grey),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '15.07.2022',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFF18181C),
                            ),
                          ),
                          Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(52),
                              color: const Color(0xFF2CAD7F).withOpacity(0.1),
                            ),
                            child:  Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                                child: const Text(
                                  'Опубликован',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff12cad7f),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }, 
            itemCount: 3,
            ),
          )
        ],
      ),
    );
  }
}
