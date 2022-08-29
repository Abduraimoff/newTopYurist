import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/bloc/verification_cubit/verification_cubit.dart';
import 'package:top_yurist/data/Models/verify/verify.dart';
import 'package:top_yurist/presentation/profile/verification_two_page.dart';
import 'package:top_yurist/utils/decorations.dart';
import 'package:top_yurist/utils/icons.dart';

import '../../utils/colors.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => VerificationPageState();
}

class VerificationPageState extends State<VerificationPage> {
  int page = 1;

  void changePage(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCubit(),
      child: Builder(builder: (context) {
        return (page == 1)
            ? Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        const _AppBarWidget(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                const _AboutInstutionWidget(),
                                SizedBox(height: 24.h),
                                const _EducationWidget(),
                                SizedBox(height: 24.h),
                                const _ExperienceWidget(),
                                SizedBox(height: 19.h),
                                SizedBox(
                                  width: double.infinity,
                                  child: CupertinoButton(
                                    color: AppColors.blue,
                                    child: Text(
                                      'Далее',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onPressed: () => changePage(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const VerificationTwoPage();
      }),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageState = context.findAncestorStateOfType<VerificationPageState>();
    return Row(
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
        Column(
          children: [
            LocaleText(
              'verification',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              '${pageState!.page}/2',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox.shrink(),
      ],
    );
  }
}

class _AboutInstutionWidget extends StatelessWidget {
  const _AboutInstutionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          decoration: TextFieldDecorations.roundedDecoration(context)
              .copyWith(hintText: 'Ваше имя или название организации'),
          controller: TextEditingController(
            text: context.read<VerificationCubit>().verify.title,
          ),
          onChanged: (value) {
            context.read<VerificationCubit>().verify.title = value;
          },
        ),
        SizedBox(height: 24.h),
        SizedBox(
          height: 140,
          child: TextField(
            maxLength: null,
            minLines: null,
            maxLines: null,
            expands: true,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            decoration:
                TextFieldDecorations.roundedDecoration(context).copyWith(
              hintText: 'О себе',
            ),
            controller: TextEditingController(
              text: context.read<VerificationCubit>().verify.description,
            ),
            onChanged: (value) {
              context.read<VerificationCubit>().verify.description = value;
            },
          ),
        ),
      ],
    );
  }
}

class _EducationWidget extends StatefulWidget {
  const _EducationWidget({Key? key}) : super(key: key);

  @override
  State<_EducationWidget> createState() => __EducationWidgetState();
}

class __EducationWidgetState extends State<_EducationWidget> {
  final verifyKey = GlobalKey<FormState>();
  String name = '';
  String start = '';
  String end = '';
  bool isUploaded = false;
  @override
  void initState() {
    final verificationCubit = context.read<VerificationCubit>();
    if (verificationCubit.verify.studies != null &&
        verificationCubit.verify.studies!.isNotEmpty) {
      final studie = verificationCubit.verify.studies!.first;
      name = studie.title;
      start = studie.startAt ?? '';
      end = studie.endAt ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Обучение',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.h),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(28, 79, 209, 0.1),
            onPressed: isUploaded
                ? null
                : () {
                    final verifyBloc = context.read<VerificationCubit>();
                    if (verifyKey.currentState!.validate()) {
                      final studie =
                          Studie(title: name, startAt: start, endAt: end);
                      verifyBloc.addEducation(studie);
                      setState(() {
                        isUploaded = true;
                      });
                    }
                  },
            child: Text(
              'Добавить место учебы',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExperienceWidget extends StatefulWidget {
  const _ExperienceWidget({Key? key}) : super(key: key);

  @override
  State<_ExperienceWidget> createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<_ExperienceWidget> {
  final verifyKey = GlobalKey<FormState>();
  String name = '';
  String start = '';
  String end = '';
  bool isUploaded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Опыт работы',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.h),
        Form(
            key: verifyKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'не может быть пустым';
                    }
                    return null;
                  },
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                  decoration: TextFieldDecorations.roundedDecoration(context)
                      .copyWith(hintText: 'Название организации'),
                  onChanged: (v) {
                    name = v;
                    if (isUploaded) {
                      setState(() {
                        isUploaded = false;
                      });
                    }
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        validator: (value) {
                          if (value == null) {
                            return 'введите год';
                          }
                          return null;
                        },
                        hint: Text(
                          'Начало',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        decoration:
                            TextFieldDecorations.roundedDecoration(context),
                        borderRadius: BorderRadius.circular(10),
                        menuMaxHeight: 200.h,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        value: null,
                        items: [
                          for (int i = DateTime.now().year; i > 1940; i--)
                            DropdownMenuItem(
                              value: i,
                              child: Text(i.toString()),
                            )
                        ],
                        onChanged: (value) {
                          start = value.toString();
                          if (isUploaded) {
                            setState(() {
                              isUploaded = false;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        validator: (value) {
                          if (value == null) {
                            return 'введите год';
                          }
                          return null;
                        },
                        hint: Text(
                          'Окончание',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        decoration:
                            TextFieldDecorations.roundedDecoration(context),
                        borderRadius: BorderRadius.circular(10),
                        menuMaxHeight: 200.h,
                        value: null,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        items: [
                          for (int i = DateTime.now().year; i > 1940; i--)
                            DropdownMenuItem(
                              value: i,
                              child: Text(i.toString()),
                            )
                        ],
                        onChanged: (value) {
                          end = value.toString();
                          if (isUploaded) {
                            setState(() {
                              isUploaded = false;
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            )),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(28, 79, 209, 0.1),
            onPressed: isUploaded
                ? null
                : () {
                    final verifyBloc = context.read<VerificationCubit>();
                    if (verifyKey.currentState!.validate()) {
                      final job = Job(title: name, startAt: start, endAt: end);
                      verifyBloc.addJobExperences(job);
                      setState(() {
                        isUploaded = true;
                      });
                    }
                  },
            child: Text(
              'Добавить место работы',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddInstutionWidget extends StatelessWidget {
  AddInstutionWidget({Key? key, required this.verifyKey}) : super(key: key);
  final GlobalKey<FormState> verifyKey;
  String name = '';
  String start = '';
  String end = '';
  bool isUploaded = false;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: verifyKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'не может быть пустым';
                }
                return null;
              },
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              decoration: TextFieldDecorations.roundedDecoration(context)
                  .copyWith(hintText: 'Название организации'),
              onChanged: (v) {
                name = v;
              },
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    validator: (value) {
                      if (value == null) {
                        return 'введите год';
                      }
                      return null;
                    },
                    hint: Text(
                      'Начало',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: TextFieldDecorations.roundedDecoration(context),
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 200.h,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    value: null,
                    items: [
                      for (int i = DateTime.now().year; i > 1940; i--)
                        DropdownMenuItem(
                          value: i,
                          child: Text(i.toString()),
                        )
                    ],
                    onChanged: (value) {
                      start = value.toString();
                    },
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    validator: (value) {
                      if (value == null) {
                        return 'введите год';
                      }
                      return null;
                    },
                    hint: Text(
                      'Окончание',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: TextFieldDecorations.roundedDecoration(context),
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 200.h,
                    value: null,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    items: [
                      for (int i = DateTime.now().year; i > 1940; i--)
                        DropdownMenuItem(
                          value: i,
                          child: Text(i.toString()),
                        )
                    ],
                    onChanged: (value) {
                      end = value.toString();
                    },
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
