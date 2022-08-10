import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/data/Models/user/user.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';

import '../../bloc/profile_cubit/profile_cubit_cubit.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  get isSelected => null;

  @override
  Widget build(BuildContext context) {
    Widget itemWidget({required int? amount, required String title}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${amount ?? 0}',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          LocaleText(
            title,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, User>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
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
                          'statistics',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Chip(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      label: Text(
                        'Данные за период 01.08.2022 -06.08.2022',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      backgroundColor: AppColors.grey.withOpacity(0.1),
                    ),
                    SizedBox(height: 18.h),
                    Container(
                      padding: EdgeInsets.all(16.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.04),
                            offset: Offset(0, 2),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: itemWidget(
                                  amount: state.amountApplications,
                                  title: 'numberOfApplications',
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: itemWidget(
                                  amount: state.amountSelects,
                                  title: 'selected',
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Divider(height: 0),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: itemWidget(
                                  amount: state.amountCOmplates,
                                  title: 'performed',
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: itemWidget(
                                  amount: state.amountCalls,
                                  title: 'calls',
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Divider(height: 0),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: itemWidget(
                                  amount: state.amountSentMessages,
                                  title: 'sentMessages',
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: itemWidget(
                                  amount: state.amountIncomingMessages,
                                  title: 'incomingMessages',
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Divider(height: 0),
                          ),
                          itemWidget(
                            amount: state.amountFavorites,
                            title: 'youAreInFavorite',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
