import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Bloc/MessageTemplate/message_template_bloc.dart';
import 'package:top_yurist/presentation/UserUploadedServices/create_template.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../data/Models/Lawyer/lawyer_select_service_detail.dart';
import '../../data/Models/message_template/message_template.dart';

class UploadedServiceDetail extends StatefulWidget {
  static const routeName = "uploaded";

  const UploadedServiceDetail({Key? key}) : super(key: key);

  @override
  State<UploadedServiceDetail> createState() => _UploadedServiceDetailState();
}

class _UploadedServiceDetailState extends State<UploadedServiceDetail> {
  final MessageTemplateBloc _templateBloc = MessageTemplateBloc();
  List<MessageTemplateResponse>? templates;

  @override
  void initState() {
    _templateBloc.add( GetMessageTemplateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Datum data = ModalRoute.of(context)?.settings.arguments as Datum;
    ScreenUtil.init(context, designSize: const Size(375, 812));
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
            Text(
              data.ownerFullName ?? "",
              style: const TextStyle(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.description ?? "",
              style: const TextStyle(color: Colors.grey),
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
              itemCount: data.photos?.length ?? 0,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 8 : 0, right: 8),
                  child: SizedBox(
                    width: 94.w,
                    height: 94.w,
                    child: CachedNetworkImage(
                      imageUrl: data.photos?[index] ?? "",
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
            child: BlocListener<MessageTemplateBloc, MessageTemplateState>(
              bloc: _templateBloc,
  listener: (context, state) {
   if(state is MessageTemplateListLoadedState){
     templates = state.response;
   }
  },
  child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) {
                    return FractionallySizedBox(
                      heightFactor: 1.7,
                      child: MessageModal(templates: templates,),
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
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MessageModal extends StatelessWidget {
  final List<MessageTemplateResponse>? templates;
  const MessageModal({
    Key? key, this.templates
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    final TextEditingController controller = TextEditingController();
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.sp),
              topLeft: Radius.circular(30.sp),
            ),
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 20.h),
                Center(
                  child: Container(
                    width: 50.w,
                    height: 3.h,
                    color: Colors.grey,
                  ),
                ),
                 SizedBox(height: 28.h),
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
                  child:  TextField(
                    controller: controller,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: const Color(0xFF18181C)),
                    decoration: InputDecoration(
                      hintText: 'Введите текст',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: const Color(0xFF18181C)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                 SizedBox(height: 28.h),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(CreateTemplateScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        'Шаблоны',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: const Color(0xFF18181C),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.black),
                    ],
                  ),
                ),
                 SizedBox(height: 12.h),
              Row(children: templates!.map((e) {
                return Padding(
                  padding:  EdgeInsets.only(right: 8.w),
                  child: InkWell(
                    onTap: (){
                    setState((){
                      controller.text = e.description ?? "";
                    });
                    },
                    child: SizedBox(
                      width: 102,
                      height: 98,
                      child: DottedBorder(
                        color: const Color(0xFF858DA3),
                        radius:  Radius.circular(5.sp),
                        child:  Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Text(
                            e.description ?? "",
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),),
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
    );
  }
}
