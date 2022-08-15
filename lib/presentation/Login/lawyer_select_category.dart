import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Bloc/ProblemType/problem_type_bloc.dart';
import 'package:top_yurist/bloc/Cubit/Auth/auth_user_cubit.dart';
import 'package:top_yurist/presentation/Home/home_screen.dart';
import 'package:top_yurist/presentation/widgets/base_appbar.dart';

import '../../bloc/Bloc/Auth/auth_bloc.dart';
import '../../utils/colors.dart';

class LawyerSelectCategory extends StatefulWidget {
  static const String routeName = "lawyer/select/category";

  const LawyerSelectCategory({Key? key}) : super(key: key);

  @override
  State<LawyerSelectCategory> createState() => _LawyerSelectCategoryState();
}

class _LawyerSelectCategoryState extends State<LawyerSelectCategory> {
  final ProblemTypeBloc _bloc = ProblemTypeBloc();
  final AuthBloc _authBloc = AuthBloc();
  @override
  void initState() {
    _bloc.add(GetProblemsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
  listener: (context, state) {
    if(state is RegisterUserSuccessState){
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    }
  },
  child: Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: Text(
          "Выберите свою категорию",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: BlocBuilder<ProblemTypeBloc, ProblemTypeState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ProblemLoadedSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      return BlocBuilder<AuthUserCubit, AuthUserState>(
                        builder: (context, stateCubit) {
                          if (stateCubit is CollectUserData) {
                            return ListTile(

                              contentPadding: EdgeInsets.only(
                                left: 16.w,
                                right: 0
                              ),

                              title: Row(
                                children: [
                                  Container(
                                    height: 18.h,
                                    width: 18.h,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: stateCubit.newUser.problemTypes!
                                            .contains(state.response[i].id)
                                            ? AppColors.primary
                                            : AppColors.grey),
                                    child: stateCubit.newUser.problemTypes!
                                        .contains(state.response[i].id)
                                        ? const Center(
                                      child: Icon(
                                        Icons.check,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                    )
                                        : null,
                                  ),
                                  SizedBox(width: 15.w,),
                                  Text(
                                      state.response[i].title?.ruRu ?? ""),
                                ],
                              ),
                              onTap: () {
                                stateCubit.newUser.problemTypes!
                                        .contains(state.response[i].id)
                                    ? context
                                        .read<AuthUserCubit>()
                                        .deleteProblemType(
                                            state.response[i].id.toString())
                                    : context
                                        .read<AuthUserCubit>()
                                        .getProblemType(
                                            state.response[i].id.toString());
                              },
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      );
                    },
                    itemCount: state.response.length,
                  ),
                ),
                Container(
                    height: 48.h,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp)),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _authBloc.add(RegisterUserEvent(context.read<AuthUserCubit>().newUser));

                      },
                      style:
                          ElevatedButton.styleFrom(primary: AppColors.primary),
                      child: LocaleText(
                        'save',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: AppColors.white),
                      ),
                    )),
                SizedBox(
                  height: 40.h,
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ),
);
  }
}
