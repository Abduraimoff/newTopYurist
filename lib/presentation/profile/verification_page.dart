import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/bloc/verification_cubit/verification_cubit.dart';
import 'package:top_yurist/data/Repositories/upload_image.dart';
import 'package:top_yurist/presentation/profile/verification_two_page.dart';
import 'package:top_yurist/utils/decorations.dart';
import 'package:top_yurist/utils/get_image.dart';
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
              state.verify.title != null &&
              state.verify.title!.isNotEmpty &&
              state.verify.diplomaPhoto != null;
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
                            const _DiplomPhotoEidget(),
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
            color: const Color(0xFF18181C),
          ),
        ),
        Column(
          children: [
            LocaleText(
              'verification',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF18181C),
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
              .copyWith(hintText: 'Название бюро, компании или коллегии*'),
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
              hintText: 'Коротко о деятельности и предоставляемых услугах',
            ),
            controller: descriptionController,
            onChanged: context.read<VerificationCubit>().setDescription,
          ),
        ),
      ],
    );
  }
}

class _EducationWidget extends StatelessWidget {
  const _EducationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocState =
        context.read<VerificationCubit>().state as VerificationLoadedState;

    final name = blocState.verify.studies?.first.title;
    final nameController = TextEditingController(text: name);

    final start = blocState.verify.studies?.first.startAt?.substring(0, 4);

    return BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
      state as VerificationLoadedState;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Высшее образование*',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16.h),
          Column(
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
                    .copyWith(hintText: 'Название ВУЗа'),
                onChanged: (v) {
                  context.read<VerificationCubit>().setEducationTitle(v);
                },
                controller: nameController,
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == null) {
                    return 'введите год';
                  }
                  return null;
                },
                hint: Text(
                  'Год начала обчучения',
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
                value: start,
                items: [
                  for (int i = DateTime.now().year; i > 1940; i--)
                    DropdownMenuItem(
                      value: i.toString(),
                      child: Text(i.toString()),
                    )
                ],
                onChanged: (v) {
                  context.read<VerificationCubit>().setEducatioYear(v);
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      );
    });
  }
}

class _DiplomPhotoEidget extends StatefulWidget {
  const _DiplomPhotoEidget({Key? key}) : super(key: key);

  @override
  State<_DiplomPhotoEidget> createState() => __DiplomPhotoEidgetState();
}

class __DiplomPhotoEidgetState extends State<_DiplomPhotoEidget> {
  bool isImageLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Диплом *',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.h),
        BlocBuilder<VerificationCubit, VerificationState>(
          builder: (context, state) {
            state as VerificationLoadedState;
            return Column(
              children: [
                (state.verify.diplomaPhoto != null)
                    ? Image.network(
                        state.verify.diplomaPhoto!,
                        height: 174.h,
                      )
                    : const SizedBox(),
                SizedBox(height: 16.h),
              ],
            );
          },
        ),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(28, 79, 209, 0.1),
            onPressed: isImageLoading
                ? null
                : () async {
                    final cubit = context.read<VerificationCubit>();
                    final file = await pickImage(context);
                    setState(() {
                      isImageLoading = true;
                    });
                    final imageUrl = await uploadImage(file: file);
                    cubit.addDiplomPhoto(imageUrl);
                    setState(() {
                      isImageLoading = false;
                    });
                  },
            child: isImageLoading
                ? const CircularProgressIndicator.adaptive()
                : Text(
                    'Добавить фото диплома',
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
