import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:top_yurist/presentation/Login/confirmation_screen.dart';
import 'package:top_yurist/utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  static const String registerScreen = "register_screen";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? phoneCode;
  final TextEditingController _controller = TextEditingController();
  var maskFormatter =  MaskTextInputFormatter(
      mask: '### ## ##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: SafeArea(
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
              const LocaleText('type_your_number'),
              SizedBox(
                height: 32.h,
              ),
              Row(
                children: [
                  Container(
                    height: 48.h,
                    width: 100.w,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "+998",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            DropdownButton<String>(
                              style: Theme.of(context).textTheme.bodyText1,
                              items: const [
                                DropdownMenuItem<String>(
                                  value: "90",
                                  child: Text("90"),
                                ),
                                DropdownMenuItem<String>(
                                  value: "91",
                                  child: Text("91"),
                                ),
                                DropdownMenuItem<String>(
                                  value: "97",
                                  child: Text("97"),
                                ),
                                DropdownMenuItem<String>(
                                  value: "88",
                                  child: Text("88"),
                                ),
                                DropdownMenuItem<String>(
                                  value: "99",
                                  child: Text("99"),
                                ),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  phoneCode = val;
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
                          hintText: "000 00 00"),
                    ),
                  )),
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
          child: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).pushNamed(ConfirmationScreen.routeName, arguments: "+998 $phoneCode ${_controller.text}");
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
            ),
              backgroundColor: AppColors.primary,
            child: LocaleText("enter" , style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.white),),
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
