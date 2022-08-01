import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/bloc/profile_cubit/profile_cubit_cubit.dart';
import 'package:top_yurist/data/Models/user/user.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocBuilder<ProfileCubit, User>(builder: (context, state) {
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
                      backgroundImage: AssetImage(state.image),
                    ),
                    // SizedBox(height: 12.h),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Добавить фото',
                        style: TextStyle(
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                    const Text(
                      'С фотографией к вам будет больше доверия',
                      style: TextStyle(
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Ф.И.О',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                        hintText: 'Номер телефона',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
