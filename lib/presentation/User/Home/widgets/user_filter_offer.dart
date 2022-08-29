import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Bloc/Application/Cubit/user_offer_filter_cubit.dart';
import 'package:top_yurist/utils/colors.dart';

class UserFilterOffer extends StatefulWidget {
  static const String routeName = "user/filter";
  const UserFilterOffer({Key? key}) : super(key: key);

  @override
  State<UserFilterOffer> createState() => _UserFilterOfferState();
}

class _UserFilterOfferState extends State<UserFilterOffer> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(title: LocaleText("sort", style: Theme
          .of(context)
          .textTheme
          .headline3,),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.grey),
      backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: BlocBuilder<UserOfferFilterCubit, UserOfferFilterState>(
  builder: (context, state) {
    return Column(children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 17.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                    context.read<UserOfferFilterCubit>().changeFilter("PRICE");
                },
                child: Row(
                  children: [
                    Container(
                      height: 18.h,
                      width: 18.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.read<UserOfferFilterCubit>().filter == "PRICE"
                              ? AppColors.primary
                              : AppColors.grey),
                      child:  context.read<UserOfferFilterCubit>().filter == "PRICE"
                          ?  Center(
                        child: Icon(
                          Icons.check,
                          size: 10.sp,
                          color: Colors.white,
                        ),
                      )
                          : null,
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    LocaleText(
                      "by_price",
                      style: Theme.of(context)
                          .textTheme
                          .headline3,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                color: AppColors.grey,
              ),
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 17.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                context.read<UserOfferFilterCubit>().changeFilter("SOLVED_APPLICATION");
                },
                child: Row(
                  children: [
                    Container(
                      height: 18.h,
                      width: 18.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.read<UserOfferFilterCubit>().filter == "SOLVED_APPLICATION"
                              ? AppColors.primary
                              : AppColors.grey),
                      child: context.read<UserOfferFilterCubit>().filter == "SOLVED_APPLICATION"
                          ?  Center(
                        child: Icon(
                          Icons.check,
                          size: 10.sp,
                          color: Colors.white,
                        ),
                      )
                          : null,
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Text(
                      "by_rating",
                      style: Theme.of(context)
                          .textTheme
                          .headline3,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                color: AppColors.grey,
              ),
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 17.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  context.read<UserOfferFilterCubit>().changeFilter("REVIEW");
                },
                child: Row(
                  children: [
                    Container(
                      height: 18.h,
                      width: 18.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.read<UserOfferFilterCubit>().filter == "REVIEW"
                              ? AppColors.primary
                              : AppColors.grey),
                      child: context.read<UserOfferFilterCubit>().filter == "REVIEW"
                          ?  Center(
                        child: Icon(
                          Icons.check,
                          size: 10.sp,
                          color: Colors.white,
                        ),
                      )
                          : null,
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Text(
                      "by_reviews",
                      style: Theme.of(context)
                          .textTheme
                          .headline3,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                color: AppColors.grey,
              ),
            ],
          ),
        )
      ],);
  },
),
    );
  }
}
