import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:top_yurist/bloc/chat_cubit/chat_cubit.dart';
import 'package:top_yurist/data/Models/chat/chat.dart';
import 'package:top_yurist/utils/colors.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LocaleText(
                      'chats',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (state is ChatInitial) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is Chatloaded && state.chats.isEmpty) {
                      return const _ChatEmptyWidget();
                    } else if (state is Chatloaded && state.chats.isNotEmpty) {
                      return const _BodyWidget();
                    } else {
                      return const _ErrorWidget();
                    }
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class _ChatEmptyWidget extends StatelessWidget {
  const _ChatEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LocaleText(
            'empty',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 40.h),
          Image.asset('assets/images/no_message.png'),
          SizedBox(height: 40.h),
          Text(
            'На данный момент нет активных чатов',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final types = ['all', 'resolved', 'not_resolved'];
    int selectedIndex = 0;
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(height: 20.h),
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 16.w),
                itemBuilder: (context, index) => Stack(
                  children: [
                    SizedBox(
                      height: 40.h,
                      child: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        label: Center(child: LocaleText(types[index])),
                        backgroundColor: selectedIndex == index
                            ? AppColors.blue
                            : AppColors.grey.withOpacity(0.1),
                        labelStyle: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20.h),
                          onTap: () {},
                        ),
                      ),
                    )
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(width: 12.w),
                itemCount: types.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 15.h),
                      child: const Divider(height: 0),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return _ChatWidget(
                      chat: (state as Chatloaded).chats[index],
                    );
                  },
                  itemCount: (state as Chatloaded).chats.length + 1,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _ChatWidget extends StatelessWidget {
  const _ChatWidget({Key? key, required this.chat}) : super(key: key);
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w, top: 10.h, bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.user.name,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8.h),
                Text(
                  chat.lastMessage.content,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50.h),
                  ),
                  child: Text(
                    'В прцессе',
                    style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              DateFormat('hh:mm').format(chat.lastMessage.time).toString(),
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Something vent wrong'),
    );
  }
}
