import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:top_yurist/bloc/Bloc/Chat/chat_bloc.dart';
import 'package:top_yurist/bloc/Cubit/ChatFilter/chat_filter_cubit.dart';
import 'package:top_yurist/presentation/messaging/messaging_page.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../data/Models/chat/chat_response.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider<ChatBloc>(
      create: (context) => ChatBloc()..add(const GetChatsEvent('')),
),
    BlocProvider<ChatFilterCubit>(
      create: (context) => ChatFilterCubit(),
    ),
  ],
  child: SafeArea(
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
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (state is ChatInitial) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is ChatLoadedSuccess) {
                        return _BodyWidget(
                          data: state.response.data,
                        );
                      } else {
                        return const _ErrorWidget();
                      }

                    },
                  ),
                );

              },
            )
          ],
        ),
      ),
);
  }
}

class _ChatEmptyWidget extends StatelessWidget {
  const _ChatEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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

class _BodyWidget extends StatefulWidget {
  final List<ChatDatum>? data;


  const _BodyWidget({Key? key, this.data,})
      : super(key: key);

  @override
  State<_BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<_BodyWidget> {
  final List<String> chatState = ["all", "new", "in_process", "finished"];

  String takeState(int index) {
    if (index == 0) {
      return '';
    } else if (index == 1) {
      return "ACTIVE";
    } else if (index == 2) {
      return "IN_PROGRESS";
    } else {
      return "FINISHED";
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    label: Center(child: LocaleText(chatState[index])),
                    backgroundColor: context.read<ChatFilterCubit>().index == index
                        ? AppColors.blue
                        : AppColors.grey.withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: context.read<ChatFilterCubit>().index == index ? Colors.white : Colors.black,
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
                      onTap: () {
                        context.read<ChatFilterCubit>().changeIndex(index);
                        BlocProvider.of<ChatBloc>(context)
                            .add(GetChatsEvent(takeState(index)));
                      },
                    ),
                  ),
                )
              ],
            ),
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemCount: chatState.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 20.h),
        (widget.data?.isEmpty ?? true)
            ? const Center(child: _ChatEmptyWidget())
            : Expanded(
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
                        chat: widget.data?[index],
                      );
                    },
                    itemCount: (widget.data?.length ?? 0) + 1,
                  ),
                ),
              )
      ],
    );
  }
}

class _ChatWidget extends StatelessWidget {
  const _ChatWidget({Key? key, required this.chat}) : super(key: key);
  final ChatDatum? chat;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 16.w, top: 10.h, bottom: 10.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chat?.dialogUserName ?? "no name",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            DateFormat("hh:MM", 'en').format(
                                DateTime.fromMicrosecondsSinceEpoch(
                                    (chat?.createdAt ?? 0000000000000) * 1000)),
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chat?.lastMessage ?? "no message",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          height: 16.h,
                          width: 16.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.primary),
                          child: Center(
                              child: Text(
                            chat!.unreadCount.toString(),
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 10.sp,
                            ),
                          )),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50.h),
                      ),
                      child: LocaleText(
                        chat?.state ?? "",
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
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagingPage(
                    chatId: chat?.id,
                    fullName: chat?.dialogUserName,
                    imageUrl: chat?.dialogUserPhoto,
                  ),
                ),
              );
            }),
          ),
        )
      ],
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
