import 'dart:io';
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
  bool? agreement;

  Future pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 30);
      if (image == null) return;
      final temporaryImage = File(image.path);
      setState(() {
        this.image = temporaryImage;
      });
      _bloc.add(UploadImageEvent(temporaryImage));
    } on PlatformException catch (e) {
      print("filed to pick image: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: BaseAppBar(
        title: LocaleText(
          'register',
          style: Theme.of(context).textTheme.headline3,
        ),
        appBar: AppBar(),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is UploadImageSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("`Your image successfully uploaded")));
          }
          if(state is AuthErrorState){
            showDialog(context: context, builder: (context) =>  AlertDialog(content: Text(state.error.toString()),));
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
                height: 66.h,
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
              TextButton(
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
                  onChanged: (value){
                    context.read<AuthUserCubit>().getFullName(value);
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                      hintText: context.localeString('name')),
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
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                      hintText: context.localeString('surName')),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),

              Row(
                children: [
                  LocaleText("registration_offer_1", style: Theme.of(context).textTheme.bodyText1,),
                  InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (context) => AlertDialog(content: const Text('Are you confirm ?'),
                      actions: [
                        ElevatedButton(onPressed: (){
                          agreement = true;
                          context.read<AuthUserCubit>().getUserAgreement(false);
                          Navigator.of(context).pop();
                        }, child: const Text("no")),
                        ElevatedButton(onPressed: (){
                          agreement = false;
                          context.read<AuthUserCubit>().getUserAgreement(true);
                          Navigator.of(context).pop();
                        }, child: const Text("ok")), ],
                      ));
                    },
                    child: LocaleText("registration_offer_2", style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(
                        decoration: TextDecoration.underline)),
                  )

                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 48.h,
          width: double.infinity,
          child: BlocProvider(
  create: (context) => AuthUserCubit(),
  child: BlocBuilder<AuthUserCubit, AuthUserState>(
  builder: (context, state) {
    if(state is CollectUserData){
      agreement = state.newUser.agreement;
    }
    return FloatingActionButton(
      onPressed: () async{
        fullName = "${_nameController.text} ${_sureNameController.text}";
        context.read<AuthUserCubit>().getFullName(fullName??'');

        if((fullName?.length?? 0) <3){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your name should be at least 3 symbol')));
        } else if(agreement ?? false){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('please select agreement')));
        } else{
          Navigator.of(context).pushNamed(SelectRegion.routeName);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

}
