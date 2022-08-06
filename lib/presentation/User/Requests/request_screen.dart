import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'widget/not_found_request.dart';
import 'widget/requestMainScreen.dart';

class CreateRequestScreen extends StatelessWidget {
  const CreateRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: SafeArea(
        child: RequestMainScreen(),
      ),
    );
  }
}


