import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/presentation/UserUploadedServices/uploaded_service_detail.dart';
import 'package:top_yurist/utils/colors.dart';

import 'filter_by_city.dart';

class LawyerChatScreen extends StatefulWidget {
  static const String routeName = "lawyer/chat/screen";
  const LawyerChatScreen({Key? key}) : super(key: key);

  @override
  State<LawyerChatScreen> createState() => _LawyerChatScreenState();
}

class _LawyerChatScreenState extends State<LawyerChatScreen> with SingleTickerProviderStateMixin {
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
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.grey),
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
        actions:  [
          IconButton(
            onPressed: (){
              Navigator.of(context).pushNamed(FilterByCity.routeName);
            },
            padding: EdgeInsets.only(right: 16),
            icon: Icon(Icons.filter_list_rounded, color: Colors.black),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            TabBar(
              controller: tabbarController,
              indicatorPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: const Color(0xFF1C4FD1),
                borderRadius: BorderRadius.circular(58),
              ),
              tabs: const [
                Tab(text: 'Новые'),
                Tab(text: 'Выбранные'),
                Tab(text: 'Отказы'),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: tabbarController,
                children: [newCard(), newCard(), newCard()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newCard() {
    return ListView.builder(itemBuilder: (context, i){
      return SizedBox(

        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 32.h,
                          width: 32.w,
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
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(UploadedServiceDetail.routeName);
                          },
                          child: const Text(
                            'Альбина Юлдашева',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.favorite_border_outlined)
                  ],
                ),
                SizedBox(height: 10.h),
                const Text(
                  'Нужна консультация юриста по уголовному праву. Цену можем обговорить лично приме...',
                  style: TextStyle(color: Colors.grey),
                  maxLines: 2,
                ),
                SizedBox(height: 8.h),
                Row(
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
                )
              ],
            ),
          ),
        ),
      );
    },
    itemCount: 4,
    );
  }
}
