import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/decorations.dart';

class CreateReviewWidget extends StatelessWidget {
  const CreateReviewWidget({Key? key, required this.controller})
      : super(key: key);
  final PanelController controller;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller,
      minHeight: 0,
      maxHeight: 450.h,
    );
  }
}

Future<void> createReview(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.h),
    ),
    builder: (context) {
      bool isSolved = true;
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 450.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: SizedBox(
                  width: 50.w,
                  child: Divider(
                    height: 0,
                    thickness: 3.h,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Оставьте свой отзыв',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 40.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.h),
                          color: AppColors.blue.withOpacity(isSolved ? 1 : 0.1),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: LocaleText(
                                'resolved',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      isSolved ? Colors.white : AppColors.blue,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50.h),
                                  onTap: () {
                                    setState(() => isSolved = true);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.h),
                          color:
                              AppColors.blue.withOpacity(!isSolved ? 1 : 0.1),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: LocaleText(
                                'not_resolved',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      !isSolved ? Colors.white : AppColors.blue,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50.h),
                                  onTap: () {
                                    setState(() => isSolved = false);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 180.h,
                child: TextField(
                  minLines: null,
                  maxLines: null,
                  maxLength: null,
                  expands: true,
                  decoration:
                      TextFieldDecorations.roundedDecoration(context).copyWith(
                    hintText: 'Введите комментарий',
                  ),
                ),
              ),
              SizedBox(height: 35.h),
              CupertinoButton(
                color: AppColors.blue,
                child: Text(
                  "Опубликовать",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {},
              )
            ],
          ),
        );
      });
    },
  );
}
