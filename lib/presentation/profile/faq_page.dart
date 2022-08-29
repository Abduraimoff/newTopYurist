import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_yurist/bloc/faq_cubit/faq_cubit.dart';
import 'package:top_yurist/presentation/profile/faq_content_page.dart';
import 'package:top_yurist/utils/icons.dart';

import '../../utils/get_current_language_content.dart';

class PAQPage extends StatefulWidget {
  const PAQPage({Key? key}) : super(key: key);

  @override
  State<PAQPage> createState() => _PAQPageState();
}

class _PAQPageState extends State<PAQPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FAQCubit(),
      child: const _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      AppIcons.chevronLeft,
                      height: 24.h,
                      width: 24.h,
                    ),
                  ),
                  LocaleText(
                    'faq',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: BlocBuilder<FAQCubit, FaqState>(
                builder: (context, state) {
                  if (state is FaqInitial) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is FaqLoadedState) {
                    return _FAQLoadedWidget(state: state);
                  } else if (state is FaqErrorState) {
                    return _FAQErrorWidget(errorText: state.errorText);
                  }
                  return const _FAQErrorWidget(
                      errorText: 'Somesing went wrong');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FAQLoadedWidget extends StatelessWidget {
  const _FAQLoadedWidget({Key? key, required this.state}) : super(key: key);
  final FaqLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Column(
        children: state.faqs
            .map(
              (e) => Column(
                children: [
                  ListTile(
                    title: Text(
                      getCurrentLanguageContent(
                          content: e.title, context: context),
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    trailing: SvgPicture.asset(
                      AppIcons.chevronRignt,
                      height: 24.h,
                      width: 24.h,
                    ),
                    contentPadding: EdgeInsets.only(right: 16.w),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FaqContentPage(content: e.content),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 0)
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class _FAQErrorWidget extends StatelessWidget {
  const _FAQErrorWidget({Key? key, required this.errorText}) : super(key: key);
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorText),
    );
  }
}
