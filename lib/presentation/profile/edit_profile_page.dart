import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_yurist/bloc/profile_cubit/profile_cubit.dart';
import 'package:top_yurist/data/Models/user/user.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/decorations.dart';
import 'package:top_yurist/utils/get_image.dart';
import 'package:top_yurist/utils/icons.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _fioController;
  late TextEditingController _phoneController;
  final ImagePicker _picker = ImagePicker();
  bool isImageLoading = false;
  bool isEditOnProgress = false;
  String? newImage;

  @override
  void initState() {
    _fioController = TextEditingController();
    _phoneController = TextEditingController();
    final state = context.read<ProfileCubit>().state;
    state as UserState;
    _fioController.text = state.user.fullName ?? '';
    _phoneController.text = state.user.username ?? '';
    super.initState();
  }

  Future getImage() async {
    setState(() {
      isImageLoading = true;
    });
    final profileCubit = context.read<ProfileCubit>();
    try {
      final image = await pickImage(context);
      setState(() {
        isImageLoading = true;
      });
      if (image == null) {
        setState(() {
          isImageLoading = false;
        });
        return;
      }
      newImage = await profileCubit.uploadImage(image: image);
    } catch (e) {
      print("filed to pick image: $e");
    }
    setState(() {
      isImageLoading = false;
    });
  }

  Future<void> updateUser(User user) async {
    setState(() {
      isEditOnProgress = true;
    });
    try {
      final fullname = _fioController.text;
      final profileCubit = context.read<ProfileCubit>();

      await profileCubit
          .editUser(user.copyWith(fullName: fullname, profilePhoto: newImage));
      setState(() {
        isEditOnProgress = false;
      });
      pop();
    } catch (e) {
      print("edit user error $e");
    }
    setState(() {
      isEditOnProgress = false;
    });
  }

  void pop() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<ProfileCubit>().state;
    state as UserState;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          AppIcons.chevronLeft,
                          height: 20.h,
                          width: 20.h,
                        ),
                      ),
                      LocaleText(
                        'profile',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      const SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    height: 80.h,
                    width: 80.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.h),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            newImage ?? state.user.profilePhoto ?? '',
                            fit: BoxFit.cover,
                            frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                              return child;
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const ColoredBox(
                                  color: Colors.grey,
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                );
                              }
                            },
                          ),
                          isImageLoading
                              ? const ColoredBox(
                                  color: Colors.grey,
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 12.h),
                  TextButton(
                    onPressed: getImage,
                    child: Text(
                      'Добавить фото',
                      style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    'С фотографией к вам будет больше доверия',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  TextField(
                      controller: _fioController,
                      decoration:
                          TextFieldDecorations.roundedDecoration(context)
                              .copyWith(hintText: 'Ф.И.О')),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _phoneController,
                    decoration: TextFieldDecorations.roundedDecoration(context)
                        .copyWith(hintText: 'Номер телефона', enabled: false),
                  ),
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.blue),
                ),
                onPressed: isImageLoading ? null : () => updateUser(state.user),
                child: SizedBox(
                  height: 48.h,
                  child: Center(
                    child: isEditOnProgress
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : const Text('Сохранить'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
