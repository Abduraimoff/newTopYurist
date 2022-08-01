import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/bloc/cubit/profile_cubit_cubit.dart';
import 'package:top_yurist/data/Models/user/user.dart';
import 'package:top_yurist/presentation/profile/edit_profile_page.dart';
import 'package:top_yurist/presentation/profile/reviews_page.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';

class LawyerProfilePage extends StatelessWidget {
  const LawyerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LocaleText(
                    'profile',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Row(
                    children: [
                      Text(
                        'г.Ташкент',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SvgPicture.asset(
                        AppIcons.location,
                        color: AppColors.blue,
                        height: 20.h,
                        width: 20.h,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.h),
              const LawyerInfoWidget(),
              SizedBox(height: 16.h),
              const _UserTypeSwitherWidget(),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView(
                  children: [
                    const _ItemsWidget(),
                    SizedBox(height: 20.h),
                    const _PushNotificationWidget(),
                    SizedBox(height: 20.h),
                    const _LogOutWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LawyerInfoWidget extends StatelessWidget {
  const LawyerInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget itemWidget({required int amount, required String title}) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FittedBox(
                child: Text(
                  '$amount',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<ProfileCubit, User>(builder: (context, state) {
      return Container(
        width: double.infinity,
        height: 170.h,
        padding:
            EdgeInsets.only(top: 20.h, bottom: 16.h, right: 16.w, left: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              offset: Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 29.5.h,
                        backgroundImage: AssetImage(state.image),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.name,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            state.isVerified
                                ? LocaleText(
                                    'verified',
                                    style: TextStyle(
                                      color: AppColors.green,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : LocaleText(
                                    'notverified',
                                    style: TextStyle(
                                      color: AppColors.red,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                  width: 20.h,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                      },
                      child: SvgPicture.asset(AppIcons.editWithBorder),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 12.h),
            const Divider(
              color: AppColors.grey,
              height: 0,
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Row(
                children: [
                  itemWidget(
                    amount: state.amountFavorites ?? 0,
                    title: "В избранном",
                  ),
                  itemWidget(
                    amount: state.amountSelects ?? 0,
                    title: "Выбраны",
                  ),
                  itemWidget(
                    amount: state.amountCOmplates ?? 0,
                    title: "Выполнено",
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class _UserTypeSwitherWidget extends StatefulWidget {
  const _UserTypeSwitherWidget({Key? key}) : super(key: key);

  @override
  State<_UserTypeSwitherWidget> createState() => _UserTypeSwitherWidgetState();
}

class _UserTypeSwitherWidgetState extends State<_UserTypeSwitherWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, User>(builder: (context, state) {
      final profilecubit = context.read<ProfileCubit>();
      bool islawyer = state.type == UserType.lawyer;
      return Container(
        padding: EdgeInsets.all(2.h),
        height: 36.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(133, 141, 163, 0.1),
          borderRadius: BorderRadius.circular(100),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                AnimatedPositioned(
                  bottom: 0,
                  top: 0,
                  left: !islawyer ? 0 : (constraints.maxWidth / 2),
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: constraints.maxWidth / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.04),
                          offset: Offset(0, 3),
                          blurRadius: 1,
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.12),
                          offset: Offset(0, 3),
                          blurRadius: 8,
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () =>
                            profilecubit.changeUserType(UserType.notLawyer),
                        borderRadius: BorderRadius.circular(100),
                        child: Center(
                          child: LocaleText(
                            'i_am_user',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () =>
                            profilecubit.changeUserType(UserType.lawyer),
                        borderRadius: BorderRadius.circular(100),
                        child: Center(
                          child: LocaleText(
                            'i_am_lawyer',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      );
    });
  }
}

class _ItemsWidget extends StatelessWidget {
  const _ItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imetWidget({
      required String title,
      required String icon,
      required VoidCallback ontap,
      Color? iconColor,
    }) {
      return Stack(
        children: [
          SizedBox(
            height: 50.h,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              icon,
                              height: 20.h,
                              width: 20.h,
                              color: iconColor ?? AppColors.grey,
                            ),
                            SizedBox(width: 12.w),
                            LocaleText(
                              title,
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          AppIcons.chevronRignt,
                          color: AppColors.grey,
                          height: 20.h,
                          width: 20.h,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: const Divider(height: 0),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: ontap),
            ),
          )
        ],
      );
    }

    final decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.04),
          offset: Offset(0, 2),
          blurRadius: 5,
        ),
      ],
    );

    return BlocBuilder<ProfileCubit, User>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              decoration: decoration,
              child: Column(
                children: [
                  imetWidget(
                    icon: AppIcons.warning,
                    title: "verification",
                    ontap: () {},
                    iconColor:
                        state.isVerified ? AppColors.grey : AppColors.red,
                  ),
                  imetWidget(
                    icon: AppIcons.star,
                    title: "reviews",
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewsPage(),
                        ),
                      );
                    },
                  ),
                  imetWidget(
                    icon: AppIcons.global,
                    title: "switch_language",
                    ontap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              decoration: decoration,
              child: Column(
                children: [
                  imetWidget(
                    icon: AppIcons.messages,
                    title: "support_chat",
                    ontap: () {},
                  ),
                  imetWidget(
                    icon: AppIcons.messageQuestion,
                    title: "faq",
                    ontap: () {},
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PushNotificationWidget extends StatefulWidget {
  const _PushNotificationWidget({Key? key}) : super(key: key);

  @override
  State<_PushNotificationWidget> createState() =>
      __PushNotificationWidgetState();
}

class __PushNotificationWidgetState extends State<_PushNotificationWidget> {
  bool isActive = true;

  void setNotification(bool? value) {
    setState(() {
      isActive = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, User>(
      builder: (context, state) {
        return Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                offset: Offset(0, 2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocaleText(
                  'push_notifications',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                CupertinoSwitch(
                  value: isActive,
                  onChanged: setNotification,
                  activeColor: AppColors.blue,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LogOutWidget extends StatelessWidget {
  const _LogOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.logOut,
              color: AppColors.blue,
              height: 20.h,
              width: 20.h,
            ),
            SizedBox(width: 12.w),
            LocaleText(
              'log_out',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
