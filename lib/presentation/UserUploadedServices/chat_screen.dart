import 'package:flutter/material.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../utils/colors.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat-screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  late final tabbarController;

  @override
  void initState() {
    super.initState();
    tabbarController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title:  Text(
          'Чаты',
          style: Theme.of(context).textTheme.headline2,
        ),
        bottom: TabBar(
          controller: tabbarController,
          // indicatorPadding:
          // const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          unselectedLabelStyle: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.black),
          labelStyle: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.white),
          indicator: BoxDecoration(
            color: const Color(0xFF1C4FD1),
            borderRadius: BorderRadius.circular(58),
          ),
          tabs: const [
            Tab(text: 'Все', ),

            Tab(text: 'Выбранные'),
            Tab(text: 'Отклоненные'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TabBarView(
                controller: tabbarController,
                children: const [NewWidget(), NewWidget(), NewWidget()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: AppColors.grey,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Феруз Тахирович',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 12),

                    ],
                  ),
                  const Text('14:50'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Здравствуйте, Дильбар я ознаком...',
                    style: TextStyle(color: Colors.grey),
                    maxLines: 1,
                  ),
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
              const SizedBox(height: 12),
              Container(
                width: 78,
                height: 23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(52),
                  color:  AppColors.primary.withOpacity(0.1),
                ),
                child: const Center(
                  child: Text(
                    'В прцессе',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Divider(),
            ],
          )
        ],
      ),
    );
  }
}
