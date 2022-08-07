import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = "user/profile";
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.grey),
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32.w,
              height: 32.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image:
                DecorationImage(image: AssetImage('assets/images/lawyer.jpg')),
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
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.favorite_outline, color: Colors.grey),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Номер телефона: +99894 000 22 00',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Почта: exemple@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Стаж: 5 лет',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Решеных запросов: 12',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'В системе: 2 года',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 44,
                  width: 233,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF1C4FD1),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Выбрать юриста',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                 SmallButton(icon: SvgPicture.asset("assets/svg/message.svg"),),
                const SizedBox(width: 10),
                 SmallButton(icon: SvgPicture.asset("assets/svg/call.svg")),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Отзывы (2)',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Card(
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
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_outline_outlined,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Альбина Юлдашева',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 23,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(52),
                            color: const Color(0xFF2CAD7F).withOpacity(0.1),
                          ),
                          child: const Center(
                            child: Text(
                              'Решено',
                              style: TextStyle(color: Color(0xFF2CAD7F)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    const Text(
                      'Очень приятно было работать с Ферузом Тахировичем грамотно проконсультировал подготовил документы. Запрос решен на 100%',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 11),
                    const Text(
                      '15.07.2022',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final Widget icon;
  const SmallButton({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromRGBO(28, 79, 209, 0.1),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
