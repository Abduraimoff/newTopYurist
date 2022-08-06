import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFoundRequest extends StatelessWidget {
  const NotFoundRequest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Запросы',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 122),
          Center(child: Image.asset(
            "assets/images/Not Found illustration.png", height: 238.h, width: 236.w, fit: BoxFit.fill,)),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'На данный момент у вас нет запросов',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF858DA3),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF1C4FD1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Создать запрос',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}