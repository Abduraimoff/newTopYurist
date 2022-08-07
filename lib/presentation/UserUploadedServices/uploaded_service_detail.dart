import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:top_yurist/presentation/UserUploadedServices/create_template.dart';
import 'package:top_yurist/utils/colors.dart';

class UploadedServiceDetail extends StatelessWidget {
  static const routeName = "uploaded";
  const UploadedServiceDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.grey),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
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
            const SizedBox(width: 12),
            const Text(
              'Дильбар Адылова',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 2.4,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.phone, color: Colors.black),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Нужна консультация юриста по уголовному праву. Цену можем обговорить лично приме...',
              style: TextStyle(color: Colors.grey),
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined),
                    Text('Ташкент')
                  ],
                ),
                const Text('15.07.2022')
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Фото',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 94,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 8 : 0, right: 8),
                  child: Container(
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
                );
              },
            ),
          ),
          const Spacer(),
          const SizedBox(height: 33),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF1C4FD1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) {
                    return const FractionallySizedBox(
                      heightFactor: 1.7,
                      child: MessageModal(),
                    );
                  },
                );
              },
              child: const Text(
                'Отправить сообщение',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MessageModal extends StatelessWidget {
  const MessageModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 50,
                height: 3,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Cообщение',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
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
                decoration: InputDecoration(
                  hintText: 'Введите текст',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF18181C)),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 28),
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(CreateTemplateScreen.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Шаблоны',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF18181C),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 102,
              height: 98,
              child: DottedBorder(
                color: const Color(0xFF858DA3),
                radius: const Radius.circular(5),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Здравствуйте, меня зовут Феруз Тахирович я адвокат с 5 летнем стажем. Могу помочь с вашей проблемой...',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 130),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF1C4FD1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Отправить',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
