import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/bloc/verification_cubit/verification_cubit.dart';
import 'package:top_yurist/data/Repositories/upload_image.dart';
import 'package:top_yurist/presentation/profile/verification_page.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/get_image.dart';
import 'package:top_yurist/utils/icons.dart';
import 'package:top_yurist/utils/upload_image_types.dart';

class VerificationTwoPage extends StatefulWidget {
  const VerificationTwoPage({Key? key}) : super(key: key);

  @override
  State<VerificationTwoPage> createState() => _VerificationTwoPageState();
}

class _VerificationTwoPageState extends State<VerificationTwoPage> {
  @override
  Widget build(BuildContext context) {
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
                      SizedBox(height: 25.h),
                      const _InformationWidget(),
                      SizedBox(height: 25.h),
                      const _UploadImageWidget(
                        buttonNameWithImage: 'Добавить фото паспорта',
                        buttonNameWithoutImage: 'Изменить фото паспорта или ID',
                        title: 'Парспорт или ID*',
                        uploadImageType: UploadImageTypes.passport,
                      ),
                      SizedBox(height: 28.h),
                      const _UploadImageWidget(
                        buttonNameWithImage: 'Сделать селфи',
                        buttonNameWithoutImage: 'Изменить фото',
                        title: 'Фото (Селфи)*',
                        uploadImageType: UploadImageTypes.selfi,
                      ),
                      SizedBox(height: 28.h),
                      const _UploadImageWidget(
                        buttonNameWithImage: 'Добавить фото лицензии',
                        buttonNameWithoutImage: 'Изменить  фото лицензии',
                        title: 'Лицензия на вид деятельности*',
                        uploadImageType: UploadImageTypes.license,
                      ),
                      SizedBox(height: 28.h),
                      const _UploadImageWidget(
                        buttonNameWithImage: 'Добавить фото лицензии',
                        buttonNameWithoutImage: 'Изменить  фото лицензии',
                        title: 'Свидетельство о создании юр. лица',
                        uploadImageType: UploadImageTypes.civilLicense,
                      ),
                      SizedBox(height: 30.h),
                      const _AgreementsWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InformationWidget extends StatelessWidget {
  const _InformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.6.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(133, 141, 163, 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Данная информация не будет отображаться в вашем профиле. Ваши данные будут проверенны администрацией.',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF858DA3),
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verificationFirstState =
        context.findAncestorStateOfType<VerificationPageState>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            verificationFirstState?.changePage(1);
          },
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
              '2/2',
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

class _DiplomWidget extends StatelessWidget {
  const _DiplomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Диплом',
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
            child: Text(
              'Добавьте фото диплома',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
            onPressed: () async {
              final cubit = context.read<VerificationCubit>();
              final file = await pickImage(context);
              final imageUrl = await uploadImage(file: file);
              cubit.addDiplomPhoto(imageUrl);
            },
          ),
        ),
      ],
    );
  }
}

class _LicenseWidget extends StatelessWidget {
  const _LicenseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Лицензия*',
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
                (state.verify.licensePhoto != null)
                    ? Image.network(
                        state.verify.licensePhoto!,
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
            child: Text(
              'Добавьте фото лицензии',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
            onPressed: () async {
              final cubit = context.read<VerificationCubit>();
              final file = await pickImage(context);
              final imageUrl = await uploadImage(file: file);
              cubit.addLicensePhotoPhoto(imageUrl);
            },
          ),
        ),
      ],
    );
  }
}

class _ExtractWidget extends StatelessWidget {
  const _ExtractWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Выписка*',
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
                (state.verify.extractPhoto != null)
                    ? Image.network(
                        state.verify.extractPhoto!,
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
            child: Text(
              'Добавьте фото лицензии',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
            onPressed: () async {
              final cubit = context.read<VerificationCubit>();
              final file = await pickImage(context);
              final imageUrl = await uploadImage(file: file);
              cubit.addExtractPhotoPhoto(imageUrl);
            },
          ),
        ),
      ],
    );
  }
}

class _StateLicenseWidget extends StatelessWidget {
  const _StateLicenseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Государственную лицензию*',
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
                (state.verify.civilLicensePhoto != null)
                    ? Image.network(
                        state.verify.civilLicensePhoto!,
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
            onPressed: () async {
              final cubit = context.read<VerificationCubit>();
              final file = await pickImage(context);
              final imageUrl = await uploadImage(file: file);
              cubit.addCivilLicensePhotoPhoto(imageUrl);
            },
            child: Text(
              'Добавьте фото лицензии',
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

class _AgreementsWidget extends StatefulWidget {
  const _AgreementsWidget({Key? key}) : super(key: key);

  @override
  State<_AgreementsWidget> createState() => _AgreementsWidgetState();
}

class _AgreementsWidgetState extends State<_AgreementsWidget> {
  bool isActive = false;
  bool isVerifyInProsses = false;

  Future<void> verify() async {
    final verifyCubit = context.read<VerificationCubit>();
    setState(() {
      isVerifyInProsses = true;
    });
    final isVerify = await verifyCubit.verify();
    setState(() {
      isVerifyInProsses = false;
    });
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Column(
          children: [
            Image.asset(
              isVerify
                  ? 'assets/images/accepted.png'
                  : 'assets/images/rejected.png',
              height: 57.h,
              width: 44.w,
            ),
            Text(
              isVerify ? 'Ваша заявка отпавлена' : 'Что-то пошло не так',
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700),
            )
          ],
        ),
        content: Text(
          isVerify
              ? 'Модерерация уже начала прокерку'
              : 'Мы уже работаем над устранением проьлемы',
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
        ),
        actions: [
          CupertinoButton(
            child: const Text('Ок'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
      state as VerificationLoadedState;
      final canSubmit = isActive &&
          state.verify.passportBackPhoto != null &&
          state.verify.passportFrontPhoto != null &&
          state.verify.diplomaPhoto != null &&
          state.verify.licensePhoto != null &&
          state.verify.extractPhoto != null &&
          state.verify.civilLicensePhoto != null &&
          !isVerifyInProsses;
      return Column(
        children: [
          Row(
            children: [
              SizedBox(
                child: Checkbox(
                  activeColor: AppColors.blue,
                  value: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value ?? false;
                    });
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Согласен на сбор, обработку персональных данных',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF858DA3),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              borderRadius: BorderRadius.circular(8),
              color: canSubmit
                  ? AppColors.blue
                  : const Color.fromRGBO(28, 79, 209, 0.1),
              onPressed: canSubmit ? verify : null,
              child: Text(
                'Пройти верификацию',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: canSubmit ? Colors.white : AppColors.blue,
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}

class _UploadImageWidget extends StatefulWidget {
  const _UploadImageWidget({
    Key? key,
    required this.buttonNameWithImage,
    required this.buttonNameWithoutImage,
    required this.uploadImageType,
    required this.title,
  }) : super(key: key);

  final UploadImageTypes uploadImageType;
  final String buttonNameWithImage;
  final String buttonNameWithoutImage;
  final String title;

  @override
  State<_UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<_UploadImageWidget> {
  bool isImageLoading = false;

  Future<void> onButtonTap() async {
    final cubit = context.read<VerificationCubit>();
    final file = await pickImage(context);
    setState(() {
      isImageLoading = true;
    });
    final imageUrl = await uploadImage(file: file);
    switch (widget.uploadImageType) {
      case UploadImageTypes.civilLicense:
        {
          cubit.addCivilLicensePhotoPhoto(imageUrl);
        }
        break;
      case UploadImageTypes.license:
        {
          cubit.addLicensePhotoPhoto(imageUrl);
        }
        break;
      case UploadImageTypes.diplom:
        {
          cubit.addDiplomPhoto(imageUrl);
        }
        break;
      case UploadImageTypes.passport:
        {
          cubit.addPassportFrontPhoto(imageUrl);
        }
        break;
      case UploadImageTypes.selfi:
        {
          cubit.addPassportBackPhoto(imageUrl);
        }
        break;
    }
    cubit.addExtractPhotoPhoto(imageUrl);
    setState(() {
      isImageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
      state as VerificationLoadedState;
      final photo = getImageFromObject(
          type: widget.uploadImageType, verify: state.verify);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          Column(
            children: [
              (photo != null)
                  ? Image.network(
                      photo,
                      height: 174.h,
                    )
                  : const SizedBox(),
              SizedBox(height: 16.h),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(28, 79, 209, 0.1),
              onPressed: isImageLoading ? null : onButtonTap,
              child: isImageLoading
                  ? const CircularProgressIndicator.adaptive()
                  : Text(
                      (photo == null)
                          ? widget.buttonNameWithoutImage
                          : widget.buttonNameWithImage,
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
    ;
  }
}
