import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:top_yurist/bloc/Bloc/MessageTemplate/message_template_bloc.dart';
import 'package:top_yurist/bloc/Offer/offer_bloc.dart';
import 'package:top_yurist/presentation/UserUploadedServices/create_template.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../data/Models/Lawyer/lawyer_select_service_detail.dart';
import '../widgets/message_bottom_sheet.dart';

class UploadedServiceDetail extends StatelessWidget {
  static const String routeName = "uploaded/route";
   UploadedServiceDetail({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();


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
            SizedBox(width: 12.w),
            Text(
              data.ownerFullName ?? "",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                height: 2.4,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: const Icon(Icons.phone, color: Colors.black),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.description ?? "",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    Text(data.regionTitle?.ruRu ?? "")
                  ],
                ),
                Text(DateFormat("dd.MM.yyyy", 'en').format(
                    DateTime.fromMicrosecondsSinceEpoch(
                        (data.createdAt ?? 0000000000000) * 1000)))
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: LocaleText(
              'photo',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 94.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.photos?.length ?? 0,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 8 : 0, right: 8),
                  child: SizedBox(
                    width: 94.w,
                    height: 94.w,
                    // child: CachedNetworkImage(
                    //   imageUrl: data.photos?[index] ?? "",
                    // ),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          SizedBox(height: 33.h),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1C4FD1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  isDismissible: false,
                  builder: (context) {
                    return MessageModal(
                      key: _formKey,
                      applicationId: data.id,
                    );
                  },
                );
              },
              child: LocaleText(
                'send_message',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: AppColors.white),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
