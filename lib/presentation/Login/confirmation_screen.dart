import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:top_yurist/bloc/Bloc/Auth/auth_bloc.dart';
import 'package:top_yurist/presentation/Home/home_screen.dart';
import 'package:top_yurist/presentation/Login/register_profile.dart';
import 'package:top_yurist/presentation/User/Home/home_screen_user.dart';
import 'package:top_yurist/utils/colors.dart';
import '../../bloc/Cubit/Auth/auth_user_cubit.dart';

class ConfirmationScreen extends StatefulWidget {
  static const String routeName = "confirmation_screen";

  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isPlaying = true;
  String? phoneCode;
  String? _phoneNumber;
  final AuthBloc _bloc = AuthBloc();
  final OtpFieldController _controller  = OtpFieldController();
  String? error;
  bool _isLoading = false;
  
  

  @override
  void didChangeDependencies() {
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    isPlaying = true;
    super.didChangeDependencies();
  }

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() {
    if (countText == '00:00') {}
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.grey),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _bloc,
  listener: (context, state) {
      if(state is OtpCodeSuccessState){
        setState(() {
          _isLoading = false;
        });
        if((state.response?.userExits?? false) &&  (state.response?.data?.fullName != null)){
          if(state.response?.data?.userType == "lawyer"){
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          }else {
            Navigator.of(context).pushNamed(HomeScreenUser.routeName);
          }
        } else{
          Navigator.of(context).pushNamed(RegisterProfile.routeName);
        }

      }
      if(state is AuthErrorState){
        error = state.error;
        setState(() {
          _isLoading = false;
        });
      }
  },
  child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 134.h,
              ),
              LocaleText(
                "register",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 8.h,
              ),
              LocaleText(
                'sent_code_title',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
              "+998 ${context.read<AuthUserCubit>().newUser.phoneNumber}"  ,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppColors.black),
              ),
              SizedBox(
                height: 32.h,
              ),
              OTPTextField(

                controller: _controller,
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 46.w,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  context.read<AuthUserCubit>().newUser.otpCode = pin;
                },
                onChanged: (value) {},
              ),
              SizedBox(height: 16.h,),
              Visibility(
                  visible: error == null ? false : true,
                  child: Text(error?? "", style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.red),)),
            ],
          ),
        ),
      ),
),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SizedBox(
          height: 100.h,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LocaleText(
                    "remain",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: AppColors.black.withOpacity(0.5)),
                  ),
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Text(
                      countText,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: AppColors.black.withOpacity(0.5)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 21.h,
              ),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                  _bloc.add(OtpCodeSendEvent(context: context));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.primary,
                  child: _isLoading ? const Center(child: CupertinoActivityIndicator(color: AppColors.white,)): LocaleText(
                    "next",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // SizedBox(
      //   width: double.infinity,
      //   child: ElevatedButton(
      //     onPressed: () {},
      //     child: LocaleText(
      //       "enter",
      //       style: Theme.of(context)
      //           .textTheme
      //           .headline3
      //           ?.copyWith(color: AppColors.white),
      //     ),
      //   ),
      // ),
    );
  }
}
