import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_yurist/bloc/Bloc/Auth/auth_bloc.dart';
import 'package:top_yurist/presentation/Login/select_region.dart';
import 'package:top_yurist/presentation/widgets/base_appbar.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/Cubit/Auth/auth_user_cubit.dart';

class RegisterProfile extends StatefulWidget {
  static const String routeName = "register_profile";

  const RegisterProfile({Key? key}) : super(key: key);

  @override
  State<RegisterProfile> createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile> {
  final AuthBloc _bloc = AuthBloc();
  String? phoneCode;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sureNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? image;
  String? fullName;
  bool? agreement = false;
  bool _isPhotoUploading = false;

  final Uri _url = Uri.parse('https://topyurist.uz');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Future pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 30);
      if (image == null) return;
      final temporaryImage = File(image.path);
      setState(() {
        this.image = temporaryImage;
        _isPhotoUploading = true;
      });
      _bloc.add(UploadImageEvent(temporaryImage, "user"));
    } on PlatformException catch (e) {
   rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      appBar: BaseAppBar(
        title: LocaleText(
          'registration',
          style: Theme.of(context).textTheme.headline2,
        ),
        appBar: AppBar(),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is UploadImageSuccessState) {
            setState(() {
              _isPhotoUploading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("`Your image successfully uploaded")));
          }
          if (state is AuthErrorState) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Text(state.error.toString()),
                    ));
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 13.h,
              ),
              CircleAvatar(
                backgroundColor: AppColors.black.withOpacity(0.06),
                radius: 40.sp,
                child: image == null
                    ? SvgPicture.asset(
                        "assets/svg/frame.svg",
                      )
                    : SizedBox(
                        height: 80.h,
                        width: 80.h,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.h),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            )),
                      ),
              ),
              SizedBox(
                height: 12.h,
              ),
              _isPhotoUploading
                  ? const Center(
                      child: CupertinoActivityIndicator(
                      color: AppColors.primary,
                    ))
                  : TextButton(
                      onPressed: pickImage,
                      child: LocaleText(
                        "add_photo",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: AppColors.primary),
                      )),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                height: 48.h,
                child: TextField(
                  controller: _nameController,
                  onChanged: (value) {
                    context.read<AuthUserCubit>().getFullName(value);
                  },
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black.withOpacity(0.5)),
                    contentPadding: EdgeInsets.all(14.sp),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(
                        8.0.sp,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: AppColors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(
                        8.0.sp,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  const BorderSide(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(
                        8.0.sp,
                      ),
                    ),
                    hintText: context.localeString('name'),
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                height: 48.h,
                child: TextField(
                  controller: _sureNameController,
                  decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black.withOpacity(0.5)),
                      contentPadding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(
                          8.0.sp,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: AppColors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(
                          8.0.sp,
                        ),
                      ),
                      hintText: context.localeString('name2')),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: agreement,
                  onChanged: (value) {
                    setState(
                      () {
                        agreement = value;
                      },
                    );
                  },
                  splashRadius: 3.sp,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.sp)),
                  activeColor: AppColors.primary,
                ),
                Expanded(
                    child: RichText(
                  maxLines: 2,
                  text: TextSpan(
                    children: <TextSpan>[
                       TextSpan(
                          text: context.localeString("agreement1"),
                          style:  TextStyle(fontSize: 13, color: AppColors.black.withOpacity(0.5), fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: context.localeString("agreement2"),
                          style:  TextStyle(
                              fontSize: 13, color: AppColors.black.withOpacity(0.5), fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // html.window.open("https://topyurist.uz", "Top yurist");
                              _launchUrl;
                            }),
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              height: 48.h,
              width: double.infinity,
              child: BlocProvider(
                create: (context) => AuthUserCubit(),
                child: BlocBuilder<AuthUserCubit, AuthUserState>(
                  builder: (context, state) {
                    if (state is CollectUserData) {
                      agreement = state.newUser.agreement;
                    }
                    return FloatingActionButton(
                      onPressed: () async {
                        fullName =
                            "${_nameController.text} ${_sureNameController.text}";
                        context.read<AuthUserCubit>().getUserAgreement(true);
                        context
                            .read<AuthUserCubit>()
                            .getFullName(fullName ?? '');

                        if (_nameController.text.length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Your name should be at least 3 symbol')));
                        } else if (_sureNameController.text.length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Your surname should be at least 3 symbol')));
                        } else {
                          Navigator.of(context)
                              .pushNamed(SelectRegion.routeName);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.primary,
                      child: LocaleText(
                        "next",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: AppColors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
