import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/bloc/profile_cubit/profile_cubit.dart';
import 'package:top_yurist/data/Models/user/user.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/decorations.dart';
import 'package:top_yurist/utils/icons.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _fioController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    _fioController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child:
            BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          state as UserState;
          _fioController.text = state.user.fullName ?? '';
          _phoneController.text = state.user.username ?? '';
          return SafeArea(
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
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage(state.user.profilePhoto ?? ''),
                      onBackgroundImageError: (exception, stackTrace) {},
                    ),
                    // SizedBox(height: 12.h),
                    TextButton(
                      onPressed: () {},
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
                      decoration:
                          TextFieldDecorations.roundedDecoration(context)
                              .copyWith(
                                  hintText: 'Номер телефона', enabled: false),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.blue),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    height: 48.h,
                    child: const Center(
                      child: Text('Сохранить'),
                    ),
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
