import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';

class LawyerProfilePage extends StatelessWidget {
  const LawyerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 870));
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
              const _SwitherWidget(),
              SizedBox(height: 20.h),
              const _ItemsWidget(),
              SizedBox(height: 20.h),
              const _PushNotificationWidget(),
              SizedBox(height: 20.h),
              const _LogOutWidget(),
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
            Text(
              '$amount',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }

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
                      backgroundImage:
                          const AssetImage('assets/images/lawyer.jpg'),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Феруз Тахирович',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          LocaleText(
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
                    onTap: () {},
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
          Row(
            children: [
              itemWidget(amount: 5, title: "В избранном"),
              itemWidget(amount: 6, title: "Выбраны"),
              itemWidget(amount: 4, title: "Выполнено"),
            ],
          )
        ],
      ),
    );
  }
}

class _SwitherWidget extends StatefulWidget {
  const _SwitherWidget({Key? key}) : super(key: key);

  @override
  State<_SwitherWidget> createState() => __SwitherWidgetState();
}

class __SwitherWidgetState extends State<_SwitherWidget> {
  bool islawyer = false;
  @override
  Widget build(BuildContext context) {
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
                      onTap: () {
                        setState(() {
                          islawyer = false;
                        });
                      },
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
                      onTap: () {
                        setState(() {
                          islawyer = true;
                        });
                      },
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
      return SizedBox(
        height: 50.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
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
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    AppIcons.arrowRignt,
                    color: AppColors.grey,
                    height: 20.h,
                    width: 20.h,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Divider(height: 0),
            )
          ],
        ),
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

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: decoration,
          child: Column(
            children: [
              imetWidget(
                icon: AppIcons.warning,
                title: "Верификация",
                ontap: () {},
                iconColor: AppColors.red,
              ),
              imetWidget(
                icon: AppIcons.star,
                title: "Отзывы",
                ontap: () {},
              ),
              imetWidget(
                icon: AppIcons.global,
                title: "Смена языка",
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
                title: "Чат с поддержкой",
                ontap: () {},
              ),
              imetWidget(
                icon: AppIcons.messageQuestion,
                title: "FAQ",
                ontap: () {},
              ),
            ],
          ),
        ),
      ],
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
            Text(
              'Push уведомления',
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
            Text('Выйти')
          ],
        ),
      ),
    );
  }
}
