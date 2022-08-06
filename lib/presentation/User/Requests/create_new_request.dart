import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/utils/colors.dart';

class CreateNewRequest extends StatefulWidget {
  static const String routeName = "create_request";
  const CreateNewRequest({Key? key}) : super(key: key);

  @override
  State<CreateNewRequest> createState() => _CreateNewRequestState();
}

class _CreateNewRequestState extends State<CreateNewRequest> {
  final List<String> _categories = ['1', '2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Создание запроса',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 2.4,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Container(
            // width: double.infinity,
            // height: 48,
            // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(8),
            //   border: Border.all(
            //     color: const Color(0xFF858DA3),
            //     width: 1,
            //   ),
            // ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: const [
            //       Text(
            //         'Выберите ктегорию запроса',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w400,
            //           fontSize: 14,
            //           color: Colors.black,
            //         ),
            //       ),
            //       Icon(Icons.keyboard_arrow_down, color: Colors.black),
            //     ],
            //   ),
            // ),
            Container(
              width: double.infinity,
              height: 48,
              // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF858DA3),
                  width: 1,
                ),
              ),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  hintText: 'Выберите ктегорию запроса',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
                ),
                items: _categories.map((city) {
                  return DropdownMenuItem(
                    child: Text(city),
                    value: city,
                  );
                }).toList(),
                onChanged: (val) {},
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF858DA3),
                  width: 1,
                ),
              ),
              child: const TextField(
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF18181C)),
                maxLines: 100,
                decoration: InputDecoration(
                  hintText: 'Введите описание',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF18181C)),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Фото',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Добавьте документы в формате jpeg. pdf.',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFF18181C),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 94,
                  height: 94,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(0xFF858DA3),
                      width: 1,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/Rectangle106.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                DottedBorder(
                  color: const Color(0xFF858DA3),
                  radius: const Radius.circular(5),
                  child: Container(
                    width: 94,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svg/gallery-import.svg", color: AppColors.grey,),
                        const SizedBox(width: 7),
                        const Text(
                          'Добавить фото',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 9,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Скрыть мой номер от юристов',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                CupertinoSwitch(
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 33),
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
                  'Опубликовать',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 27),
          ],
        ),
      ),
    );
  }
}
