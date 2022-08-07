import 'package:flutter/material.dart';
import 'package:top_yurist/presentation/UserUploadedServices/add_new_template.dart';
import 'package:top_yurist/utils/colors.dart';

class CreateTemplateScreen extends StatelessWidget {
  static const String routeName= "create/template";
  const CreateTemplateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.grey),
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF1C4FD1).withOpacity(0.10),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ChatScreen.routeName);
                },
                child: const Text(
                  'Добавить шаблон',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF1C4FD1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(
                      width: 275,
                      child: Expanded(
                        child: Text(
                          'Здравствуйте, меня зовут Феруз Тахирович я адвокат с 5 летнем стажем. Могу помочь с вашей проблемой и провести консультацию. Позвоните по номеру 97 000 00 00 с 9:00 до 18:00',
                        ),
                      ),
                    ),
                    Icon(Icons.more_horiz, color: Colors.grey)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
