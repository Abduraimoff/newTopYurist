import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/bloc/review_cubit/review_cubit.dart';
import 'package:top_yurist/presentation/components/review_widget.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        AppIcons.chevronLeft,
                        height: 24.h,
                        width: 24.h,
                      ),
                    ),
                    LocaleText(
                      'reviews',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox.shrink(),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              _ReviewTypesWidget(),
              SizedBox(height: 20.h),
              Expanded(child: _ReviewsWidget())
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewTypesWidget extends StatelessWidget {
  const _ReviewTypesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final types = ['all', 'resolved', 'not_resolved'];
    final reviewCubit = context.watch<ReviewCubit>();
    return SizedBox(
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
                backgroundColor: reviewCubit.state.selectedREviewType == index
                    ? AppColors.blue
                    : AppColors.grey.withOpacity(0.1),
                labelStyle: TextStyle(
                  color: reviewCubit.state.selectedREviewType == index
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
                  onTap: () {
                    reviewCubit.changeReviewType(index);
                  },
                ),
              ),
            )
          ],
        ),
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemCount: types.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class _ReviewsWidget extends StatelessWidget {
  const _ReviewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(builder: (context, state) {
      return ListView.separated(
        itemBuilder: (context, index) {
          final review = state.reviews[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ReviewWidget(review: review),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemCount: state.reviews.length,
      );
    });
  }
}
