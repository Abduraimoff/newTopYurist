import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/bloc/Cubit/UserType/user_type_cubit.dart';
import 'package:top_yurist/bloc/profile_cubit/profile_cubit.dart';
import 'package:top_yurist/data/Models/user/user.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';
import 'package:top_yurist/presentation/profile/edit_profile_page.dart';
import 'package:top_yurist/presentation/profile/faq_page.dart';
import 'package:top_yurist/presentation/profile/reviews_page.dart';
import 'package:top_yurist/presentation/profile/statistics_page.dart';
import 'package:top_yurist/presentation/profile/switch_language_page.dart';
import 'package:top_yurist/presentation/profile/verification_page.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';

import '../../utils/config.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().loadUser();
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: SafeArea(
        child:
            BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          if (state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is ProfileErrorState) {
            return Center(child: Text(state.errorText));
          }
          return Padding(
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
                const UserInfoWidget(),
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
          );
        }),
      ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

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
              child: LocaleText(
                title,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state is ProfileErrorState) {
        return Text('Error');
      }
      state as ProfileLoadedState;
      return AnimatedSize(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.topCenter,
        child: Container(
          width: double.infinity,
          height: (state.user.userType == UserType.lawyer) ? 203.h : 99.h,
          padding:
              EdgeInsets.only(top: 20.h, bottom: 10.h, right: 16.w, left: 16.w),
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
                          backgroundImage: NetworkImage(
                            state.user.profilePhoto ?? '',
                          ),
                          onBackgroundImageError: (exception, stackTrace) =>
                              Colors.blue,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.user.fullName ?? "",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (state.user.userType == UserType.lawyer)
                                state.user.lawyerState == true
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
                              else
                                Text(
                                  state.user.username ?? "",
                                  style: TextStyle(
                                    color: AppColors.grey,
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
              if (state.user.userType == UserType.lawyer)
                Expanded(
                  child: Column(
                    children: [
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
                              amount: state.user.offerAmount ?? 0,
                              title: "numberOfApplications",
                            ),
                            SizedBox(width: 5.w),
                            itemWidget(
                              amount: state.user.selectedAmount ?? 0,
                              title: "selected",
                            ),
                            SizedBox(width: 5.w),
                            itemWidget(
                              amount: state.user.finishedApplicatoinCount ?? 0,
                              title: "performed",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      const Divider(
                        color: AppColors.grey,
                        height: 0,
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 20.h,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StatisticsPage(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Подробнее',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                              ),
                              SvgPicture.asset(
                                AppIcons.chevronRignt,
                                color: AppColors.blue,
                                height: 20.h,
                                width: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
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
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      final profilecubit = context.read<ProfileCubit>();
      state as ProfileLoadedState;
      bool islawyer = state.user.userType == UserType.lawyer;
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
                        onTap: ()async{
                          profilecubit.changeUserType(UserType.notLawyer);
                          context.read<UserTypeCubit>().changeType("customer");
                          await _storage.write(key: Config.userType, value: "customer");
                        }
                            ,
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
                        onTap: ()async{profilecubit.changeUserType(UserType.lawyer);
                          context.read<UserTypeCubit>().changeType("lawyer");
                          await _storage.write(key: Config.userType, value: "lawyer");
                          }
                            ,
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

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        state as ProfileLoadedState;
        return Column(
          children: [
            Container(
              width: double.infinity,
              decoration: decoration,
              child: Column(
                children: [
                  if (state.user.userType == UserType.lawyer)
                    imetWidget(
                      icon: AppIcons.warning,
                      title: "verification",
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VerificationPage(),
                          ),
                        );
                      },
                      iconColor: state.user.lawyerState == true
                          ? AppColors.grey
                          : AppColors.red,
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
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SwitchLanguagePage(),
                        ),
                      );
                    },
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
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PAQPage(),
                        ),
                      );
                    },
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
    return BlocBuilder<ProfileCubit, ProfileState>(
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
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
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
        child: InkWell(
          onTap: () async {
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName, (route) => false);
            await _storage.deleteAll();
          },
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
      ),
    );
  }
}
