import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:top_yurist/bloc/profile_cubit/profile_cubit.dart';

import 'package:top_yurist/bloc/review_cubit/review_cubit.dart';
import 'package:top_yurist/data/Models/review/review.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../data/Models/user/user.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    final reviewCubit = context.watch<ReviewCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      state as UserState;
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.h),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                offset: Offset(0, 2),
                blurRadius: 5,
              ),
            ]),
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            SizedBox(
              height: 32.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16.h,
                        backgroundImage:
                            AssetImage(review.user.profilePhoto ?? ''),
                        onBackgroundImageError: (exception, stackTrace) =>
                            const AssetImage('assets/images/userError.png'),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        review.user.fullName ?? '',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Chip(
                    label: LocaleText(
                        review.isResolved ? 'resolved' : 'not_resolved'),
                    labelStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color:
                          review.isResolved ? AppColors.green : AppColors.red,
                    ),
                    backgroundColor: review.isResolved
                        ? AppColors.green.withOpacity(0.1)
                        : AppColors.red.withOpacity(0.1),
                  )
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              review.title,
              style: TextStyle(
                color: const Color(0xFF858DA3),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat('dd.MM.yyyy').format(review.time),
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
            ),
            const Divider(),
            if (state.user.userType == UserType.lawyer)
              SizedBox(
                height: 50.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: LocaleText(
                        'show_feedback_on_your_profile',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    CupertinoSwitch(
                      value: review.isShowOnProfile!,
                      onChanged: (value) {
                        reviewCubit.editReviewShowProfile(
                          id: review.id,
                          isShowOnProfile: value,
                        );
                      },
                      activeColor: AppColors.blue,
                    )
                  ],
                ),
              )
            else
              Row(
                children: [
                  CircleAvatar(
                      backgroundImage:
                          AssetImage(review.lawyer?.profilePhoto ?? ""),
                      radius: 16.h,
                      onBackgroundImageError: (exception, stackTrace) =>
                          const AssetImage('assets/images/userError.png')),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      review.lawyer?.fullName ?? "",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
          ],
        ),
      );
    });
  }
}
