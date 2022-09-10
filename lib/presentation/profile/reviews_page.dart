import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/bloc/profile_cubit/profile_cubit.dart';
import 'package:top_yurist/bloc/review_cubit/review_cubit.dart';
import 'package:top_yurist/data/Models/review/review.dart';
import 'package:top_yurist/data/Models/user/user.dart';
import 'package:top_yurist/presentation/components/review_widget.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userType = (context.read<ProfileCubit>().state as ProfileLoadedState)
        .user
        .userType;
    return BlocProvider(
      create: (context) => ReviewCubit(userType: userType ?? UserType.lawyer),
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
              Expanded(
                child: BlocBuilder<ReviewCubit, ReviewState>(
                  builder: (context, state) {
                    if (state is ReviewInitialState) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else if (state is ReviewLoadedState) {
                      return _BodyWidget(state: state);
                    } else if (state is ReviewErrorState) {
                      return Center(child: Text(state.errorText));
                    }
                    return const Center(child: Text('Something went wrong'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key, required this.state}) : super(key: key);

  final ReviewLoadedState state;

  @override
  Widget build(BuildContext context) {
    late List<Review> reviews;
    if (state.selectedREviewType == 0) {
      reviews = state.acceptedReivews + state.rejectedRreviews;
    } else if (state.selectedREviewType == 1) {
      reviews = state.acceptedReivews;
    } else {
      reviews = state.rejectedRreviews;
    }
    return Column(
      children: [
        SizedBox(height: 20.h),
        const _ReviewTypesWidget(),
        SizedBox(height: 20.h),
        Expanded(child: _ReviewsWidget(reviews: reviews))
      ],
    );
  }
}

class _ReviewTypesWidget extends StatelessWidget {
  const _ReviewTypesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviewCubit = context.watch<ReviewCubit>();
    final state = reviewCubit.state as ReviewLoadedState;
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
                label: Center(child: LocaleText(reviewCubit.types[index])),
                backgroundColor: state.selectedREviewType == index
                    ? AppColors.blue
                    : AppColors.grey.withOpacity(0.1),
                labelStyle: TextStyle(
                  color: state.selectedREviewType == index
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
        itemCount: reviewCubit.types.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class _ReviewsWidget extends StatelessWidget {
  const _ReviewsWidget({Key? key, required this.reviews}) : super(key: key);

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ReviewWidget(review: review),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemCount: reviews.length,
    );
  }
}
