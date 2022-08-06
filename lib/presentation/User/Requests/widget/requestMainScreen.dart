

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
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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
                  padding: const EdgeInsets.all(16),
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
                                const SizedBox(width: 12),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    width: 16,
                                    height: 16,
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
                      const Text(
                        'Нужна консультация юриста по уголовному праву. Цену можем обговорить лично, примерную стоимость за консультицию и защиту по делу в суде',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 2,
                        ),
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
                            width: 78,
                            height: 23,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(52),
                              color: const Color(0xFF2CAD7F).withOpacity(0.1),
                            ),
                            child: const Center(
                              child: Text(
                                'Активный',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xff12cad7f),
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
