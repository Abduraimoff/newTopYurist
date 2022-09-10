import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:intl/intl.dart';
import 'package:top_yurist/bloc/Bloc/Chat/chat_bloc.dart';
import 'package:top_yurist/bloc/messagin_bloc/messaging_bloc.dart';
import 'package:top_yurist/data/Models/chat/chat_message_response.dart';
import 'package:top_yurist/data/Models/message_option/message_option.dart';
import 'package:top_yurist/presentation/messaging/create_review.dart';
import 'package:top_yurist/presentation/widgets/profileImage.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';
import '../../data/Models/chat/chat_response.dart';
import '../../data/Models/message/message.dart';
import '../../utils/config.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({Key? key, required this.chatId, this.fullName, this.imageUrl}) : super(key: key);
  final String? chatId;
  final String? fullName;
  final String? imageUrl;
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _BodyWidget(
        chatId: chatId,
        fullName: fullName,
        imageUrl: imageUrl,
      ),
    );
  }
}

class _BodyWidget extends StatefulWidget {
   const _BodyWidget({Key? key, required this.chatId, this.imageUrl, this.fullName}) : super(key: key);
  final String? chatId;
  final String? fullName;
  final String? imageUrl;

  @override
  State<_BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<_BodyWidget> {




  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
  create: (context) => ChatBloc()..add(GetChatsMessageEvent(widget.chatId)),
  child: BlocConsumer<ChatBloc, ChatState>(
    listener: (context, state){
      if(state is MessageSendSuccess) {

      }
    },
      builder: (context, state) {
        if (state is ChatInitial) {

          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is ChatErrorState) {
          return const _ErrorWidget();
        } else if(state is ChatMessageLoadedSuccess){
          return Column(

            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
               _AppBarWidget(fullName: widget.fullName, imageUrl: widget.imageUrl,),
               Expanded(child: _MessageAreaWidget(data: state.response,)),
              SizedBox(height: 10.h),
              const _OptionsWidget(),
              SizedBox(height: 10.h),
               _MessageFielsWidget(chatId: widget.chatId,),
            ],
          );
        }
        return const Center(child: CupertinoActivityIndicator());
      },
    ),
);
  }
}

class _AppBarWidget extends StatelessWidget {
  final String? fullName;
  final String? imageUrl;
  const _AppBarWidget({Key? key, this.fullName, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: ProfileImage(imageUrl: imageUrl,),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                fullName ?? '',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.black),
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

  }
}

class _MessageAreaWidget extends StatelessWidget  {
  final ChatMessageResponse? data;


  const _MessageAreaWidget({super.key, this.data,});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GroupedListView<MessageDatum, String>(
            elements: data!.data!,
            padding: EdgeInsets.zero,
            groupBy: (element) => DateFormat("dd.MM.yyyy", 'en').format(
                DateTime.fromMicrosecondsSinceEpoch(
                    (element.createdAt ?? 0000000000000) * 1000)),
            groupHeaderBuilder: (element) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                Text(
                  DateFormat("dd.MM.yyyy", 'en').format(
                      DateTime.fromMicrosecondsSinceEpoch(
                          (element.createdAt ?? 0000000000000) * 1000)),
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15.h),
              ],
            ),
            itemBuilder: (context, MessageDatum element) =>
                Align(
                    alignment: data?.userId == element.senderId ? Alignment.centerRight : Alignment.centerLeft,
                    child:  _MessageItemWidget(message: element, userId: data?.userId,)),
            separator: SizedBox(height: 10.h),
            useStickyGroupSeparators: true,
            floatingHeader: true,
            order: GroupedListOrder.ASC,
          ),
        );

  }
}

class _MessageItemWidget extends StatelessWidget {
  final MessageDatum message;
  final String? userId;

  const _MessageItemWidget({super.key, required this.message, required this.userId});


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
         message.senderId == userId ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: ( message.senderId == userId ? AppColors.blue : AppColors.grey)
              .withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Align(
              alignment: message.senderId == userId ? Alignment.centerLeft : Alignment.centerRight,
              child: message.messageType == "TEXT" ? Text(
                message.text ?? "",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              ) : Image.network(message.photo),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                DateFormat("dd.MM.yyyy", 'en').format(
                    DateTime.fromMicrosecondsSinceEpoch(
                        (message.createdAt ?? 0000000000000) * 1000)),
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
class _MessagePhotoItem extends StatelessWidget{
  final String? imageUrl;
  final int? date;

  const _MessagePhotoItem({super.key, this.imageUrl, this.date});
  @override
  Widget build(BuildContext context) {
    return Container(height: 193.h, width: 154,
    padding: EdgeInsets.all(9.sp),
    color: const Color(0xFFE8EDFA),
      child: Image.network(imageUrl??""),
    );
  }

}
class _OptionsWidget extends StatelessWidget {
  const _OptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oprions = [
      MessageOption(
        text: 'Оставить отзыв',
        onTap: () {
          createReview(context);
        },
        textColor: AppColors.blue,
        backgroundColor: AppColors.blue.withOpacity(0.1),
      ),
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
  final String? chatId;
   _MessageFielsWidget({Key? key, this.chatId}) : super(key: key);
final TextEditingController _controller = TextEditingController();
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
                   Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Center(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
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
                        onTap: () {
                          BlocProvider.of<ChatBloc>(context).add(SendMessageEvent(
                            message: _controller.text,
                            messageType: "TEXT",
                            chatId: chatId

                          ));
                        },
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
