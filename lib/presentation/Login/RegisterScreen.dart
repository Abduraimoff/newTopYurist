import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:top_yurist/bloc/Cubit/Auth/auth_user_cubit.dart';
import 'package:top_yurist/presentation/Login/confirmation_screen.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../bloc/Bloc/Auth/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  static const String registerScreen = "register_screen";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? phoneCode;
  final AuthBloc _bloc = AuthBloc();
  bool isLoading = false;

  String? error;
  final TextEditingController _controller = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(iconTheme: const IconThemeData(color: AppColors.black), elevation: 0, backgroundColor: AppColors.scaffoldBackground,),
        body: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is PhoneNumberVerifiedSuccessState) {
                Navigator.of(context).pushNamed(ConfirmationScreen.routeName);
                context.read<AuthUserCubit>().newUser.token =
                    state.response.token;
                isLoading = false;
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        height: !keyboardIsOpen ?  134.h : 70.h, duration: const Duration(milliseconds: 200),
                      ),
                      LocaleText(
                        "register",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                       LocaleText('type_your_number',  style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.black.withOpacity(0.5), fontWeight: FontWeight.w400),),
                      SizedBox(
                        height: 32.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48.h,
                            width: 95.w,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "+998 ",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    DropdownButton<String>(
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      underline: const SizedBox(),
                                      hint: const Text("_ _"),
                                      icon: Padding(
                                        padding:
                                             EdgeInsets.only(left: 4.w),
                                        child: SvgPicture.asset(
                                            "assets/svg/icon_arrow-right.svg"),
                                      ),
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: "90",
                                          child: Text("90",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "91",
                                          child: Text("91",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "97",
                                          child: Text("97",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "88",
                                          child: Text("88",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "99",
                                          child: Text("99",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ),
                                      ],
                                      onChanged: (val) {
                                        setState(() {
                                          phoneCode = val;
                                          error=null;
                                        });
                                      },
                                      value: phoneCode,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Expanded(
                              child: SizedBox(
                            height: 48.h,
                            child: TextField(
                              controller: _controller,
                              inputFormatters: [maskFormatter],
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: AppColors.grey),
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: AppColors.grey),
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                  ),
                                  hintStyle: Theme.of(context).textTheme.headline3,
                                  hintText: "  _  _  _  _  _  _  _"),

                            ),
                          )),
                        ],
                      ),
                      Visibility(
                          visible: error != null ? true : false,
                          child: Text(
                            error ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(color: AppColors.red),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 48.h,
            width: double.infinity,
            child: FloatingActionButton(
              onPressed: () {
                if (phoneCode == null) {
                  setState(() {
                    error = context.localeString("error_phone_code");
                  });
                } else if (_controller.text.length <= 7) {
                  setState(() {
                    error = context.localeString("error_phone_number");
                  });
                } else {
                  setState(() {
                    error == null;
                    isLoading = true;
                  });
                  context
                      .read<AuthUserCubit>()
                      .getUserPhone(("$phoneCode ") + _controller.text);

                  _bloc.add(VerifyPhoneNumber(
                      userType:
                          context.read<AuthUserCubit>().newUser.userType,
                      phoneNumber:
                          context.read<AuthUserCubit>().newUser.phoneNumber,
                      context: context));
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: AppColors.primary,
              child: isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(
                      color: AppColors.white,
                    ))
                  : LocaleText(
                      "enter",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: AppColors.white),
                    ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
