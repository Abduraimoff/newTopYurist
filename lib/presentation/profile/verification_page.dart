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

  Future<bool> onPop() async {
    if (page == 1) {
      return true;
    } else {
      changePage(1);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCubit(),
      child: BlocBuilder<VerificationCubit, VerificationState>(
          builder: (context, state) {
        if (state is VerificationInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        if ((page == 1)) {
          state as VerificationLoadedState;
          final canSubmit = state.verify.studies != null &&
              state.verify.studies!.isNotEmpty &&
              state.verify.jobs != null &&
              state.verify.jobs!.isNotEmpty &&
              state.verify.title != null &&
              state.verify.title!.isNotEmpty;
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    const _AppBarWidget(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 20.h),
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
                                onPressed:
                                    canSubmit ? () => changePage(2) : null,
                                child: Text(
                                  'Далее',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
          );
        } else {
          return WillPopScope(
            onWillPop: onPop,
            child: const VerificationTwoPage(),
          );
        }
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
    final state =
        context.read<VerificationCubit>().state as VerificationLoadedState;
    final titleController = TextEditingController(text: state.verify.title);
    final descriptionController =
        TextEditingController(text: state.verify.description);

    return Column(
      children: [
        TextField(
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          decoration: TextFieldDecorations.roundedDecoration(context)
              .copyWith(hintText: 'Ваше имя или название организации'),
          controller: titleController,
          onChanged: context.read<VerificationCubit>().setTitle,
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
            controller: descriptionController,
            onChanged: context.read<VerificationCubit>().setDescription,
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Обучение*',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16.h),
          Builder(
            builder: (context) {
              state as VerificationLoadedState;
              if (state.verify.studies == null ||
                  state.verify.studies!.isEmpty) {
                return const SizedBox();
              }

              return SizedBox(
                child: Column(children: [
                  for (int i = 0; i < state.verify.studies!.length; i++)
                    Column(
                      children: [
                        InstutionInfoWidget(
                          index: i,
                          instutionType: InstutionType.study,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  Divider(height: 32.h),
                ]),
              );
            },
          ),
          AddInstutionWidget(
            onEndChanged: (value) {
              end = value.toString();
            },
            onNameChanged: (value) {
              name = value;
            },
            onStartChanged: (value) {
              start = value.toString();
            },
            verifyKey: verifyKey,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(28, 79, 209, 0.1),
              onPressed: () {
                final verifyBloc = context.read<VerificationCubit>();
                if (verifyKey.currentState!.validate()) {
                  final studie =
                      Instution(title: name, startAt: start, endAt: end);
                  verifyBloc.addEducation(studie);
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
    });
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Опыт работы*',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16.h),
          Builder(
            builder: (context) {
              state as VerificationLoadedState;
              if (state.verify.jobs == null || state.verify.jobs!.isEmpty) {
                return const SizedBox();
              }
              return SizedBox(
                child: Column(children: [
                  for (int i = 0; i < state.verify.jobs!.length; i++)
                    Column(
                      children: [
                        InstutionInfoWidget(
                          index: i,
                          instutionType: InstutionType.job,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  Divider(height: 32.h),
                ]),
              );
            },
          ),
          AddInstutionWidget(
            onEndChanged: (value) {
              end = value.toString();
            },
            onNameChanged: (value) {
              name = value;
            },
            onStartChanged: (value) {
              start = value.toString();
            },
            verifyKey: verifyKey,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(28, 79, 209, 0.1),
              onPressed: () {
                final verifyBloc = context.read<VerificationCubit>();
                if (verifyKey.currentState!.validate()) {
                  final job =
                      Instution(title: name, startAt: start, endAt: end);
                  verifyBloc.addJobExperences(job);
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
    });
  }
}

class InstutionInfoWidget extends StatelessWidget {
  const InstutionInfoWidget(
      {Key? key, required this.index, required this.instutionType})
      : super(key: key);

  final int index;
  final InstutionType instutionType;

  @override
  Widget build(BuildContext context) {
    late Instution instution;
    final state =
        context.read<VerificationCubit>().state as VerificationLoadedState;

    if (instutionType == InstutionType.job) {
      instution = state.verify.jobs![index];
    } else {
      instution = state.verify.studies![index];
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                instution.title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8.h),
              Text(
                '${instution.startAt}-${instution.endAt ?? ''}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              final verificationCubit = context.read<VerificationCubit>();
              if (instutionType == InstutionType.job) {
                verificationCubit.deleteJobExperences(index);
              } else {
                verificationCubit.deleteEducation(index);
              }
            },
            child: SvgPicture.asset(AppIcons.trash),
          ),
        ),
      ],
    );
  }
}

class AddInstutionWidget extends StatelessWidget {
  const AddInstutionWidget({
    Key? key,
    required this.verifyKey,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onNameChanged,
  }) : super(key: key);

  final GlobalKey<FormState> verifyKey;
  final Function(String) onNameChanged;
  final Function(int?) onStartChanged;
  final Function(int?) onEndChanged;

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
            onChanged: onNameChanged,
          ),
          SizedBox(height: 16.h),
          DropdownButtonFormField<int>(
            key: UniqueKey(),
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
            onChanged: onStartChanged,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child:
          //     ),
          //     SizedBox(width: 15.w),
          //     Expanded(
          //       child: DropdownButtonFormField<int>(
          //         key: UniqueKey(),
          //         validator: (value) {
          //           if (value == null) {
          //             return 'введите год';
          //           }
          //           return null;
          //         },
          //         hint: Text(
          //           'Окончание',
          //           style: TextStyle(
          //             fontSize: 14.sp,
          //             color: Colors.grey,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         ),
          //         decoration: TextFieldDecorations.roundedDecoration(context),
          //         borderRadius: BorderRadius.circular(10),
          //         menuMaxHeight: 200.h,
          //         value: null,
          //         style: TextStyle(
          //           fontSize: 14.sp,
          //           color: Colors.grey,
          //           fontWeight: FontWeight.w400,
          //         ),
          //         items: [
          //           for (int i = DateTime.now().year; i > 1940; i--)
          //             DropdownMenuItem(
          //               value: i,
          //               child: Text(i.toString()),
          //             )
          //         ],
          //         onChanged: onEndChanged,
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
