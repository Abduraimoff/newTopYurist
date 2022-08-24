import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Bloc/UserHome/user_home_bloc.dart';


import 'widget/not_found_request.dart';
import 'widget/requestMainScreen.dart';

class CreateRequestScreen extends StatelessWidget {
  const CreateRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => UserHomeBloc(),
          child: const RequestMainScreen(),
        ),
      ),
    );
  }
}


