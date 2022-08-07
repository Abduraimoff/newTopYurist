import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:intl/intl.dart';
import 'package:top_yurist/bloc/messagin_bloc/messaging_bloc.dart';
import 'package:top_yurist/data/Models/message_option/message_option.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';
import '../../data/Models/message/message.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagingBloc(),
      child: Scaffold(
          body: _BodyWidget(
        userId: userId,
      )),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagingBloc, MessagingState>(
      builder: (context, state) {
        if (state is MessagingInitial) {
          context.read<MessagingBloc>().add(const InitEvent(userId: 1));
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is MessagingErrorState) {
          return const _ErrorWidget();
        } else {
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              const _AppBarWidget(),
              const Expanded(child: _MessageAreaWidget()),
              SizedBox(height: 10.h),
              const _OptionsWidget(),
              SizedBox(height: 10.h),
              const _MessageFielsWidget(),
            ],
          );
        }
      },
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagingBloc, MessagingState>(
        builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                AppIcons.chevronLeft,
                height: 24.h,
                width: 24.h,
              ),
            ),
            SizedBox(width: 18.w),
            CircleAvatar(
              radius: 16.h,
              backgroundImage:
                  AssetImage((state as MessagingLoaded).user.image),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                (state).user.name,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: SvgPicture.asset(
                AppIcons.call,
                color: AppColors.blue,
                height: 22.h,
                width: 22.h,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _MessageAreaWidget extends StatelessWidget {
  const _MessageAreaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagingBloc, MessagingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GroupedListView<Message, DateTime>(
            elements: (state as MessagingLoaded).messages,
            padding: EdgeInsets.zero,
            groupBy: (element) => DateTime(
                element.time.year, element.time.month, element.time.day),
            groupHeaderBuilder: (element) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                Text(
                  DateFormat('dd.MM.yyyy').format(element.time),
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15.h),
              ],
            ),
            itemBuilder: (context, Message element) =>
                _MessageItemWidget(message: element),
            separator: SizedBox(height: 10.h),
            useStickyGroupSeparators: true,
            floatingHeader: true,
            order: GroupedListOrder.ASC,
          ),
        );
      },
    );
  }
}

class _MessageItemWidget extends StatelessWidget {
  const _MessageItemWidget({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: (message.isSentByMe ? AppColors.blue : AppColors.grey)
              .withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              message.content,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                DateFormat('hh:mm').format(message.time),
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OptionsWidget extends StatelessWidget {
  const _OptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oprions = [
      MessageOption(text: 'Выбрать юриста', onTap: () {}),
      MessageOption(
        text: 'Отправить номер',
        onTap: () {},
        textColor: AppColors.blue,
        backgroundColor: AppColors.blue.withOpacity(0.1),
      ),
    ];

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: oprions.length,
        itemBuilder: (context, index) => Stack(
          children: [
            Chip(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              backgroundColor: oprions[index].backgroundColor,
              label: Center(
                child: Text(
                  oprions[index].text,
                  style: TextStyle(
                    color: oprions[index].textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: oprions[index].onTap,
                  borderRadius: BorderRadius.circular(50.h),
                ),
              ),
            )
          ],
        ),
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
      ),
    );
  }
}

class _MessageFielsWidget extends StatelessWidget {
  const _MessageFielsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.bottom + 56.h,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 8.h,
        bottom: MediaQuery.of(context).padding.bottom + 8.h,
      ),
      decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(5.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.paperclip,
                      height: 24.h,
                      width: 24.h,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(50.h),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16.w, right: 8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.h),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.h),
                        onTap: () {},
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.microphone,
                            height: 24.h,
                            width: 24.h,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
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
