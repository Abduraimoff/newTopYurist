import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Bloc/Auth/auth_bloc.dart';
import 'package:top_yurist/bloc/Cubit/Auth/auth_user_cubit.dart';
import 'package:top_yurist/data/Models/user/newUser.dart';
import 'package:top_yurist/presentation/Login/lawyer_select_category.dart';
import 'package:top_yurist/presentation/User/Home/home_screen_user.dart';
import 'package:top_yurist/presentation/widgets/base_appbar.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../bloc/Bloc/Regions/regions_bloc.dart';

class SelectRegion extends StatefulWidget {
  static const routeName = "Select-region";

  const SelectRegion({Key? key}) : super(key: key);

  @override
  State<SelectRegion> createState() => _SelectRegionState();
}

class _SelectRegionState extends State<SelectRegion> {
  final RegionsBloc _bloc = RegionsBloc();
  final AuthBloc _authBloc = AuthBloc();
  NewUser? user;
  bool _isLoading = false;
  @override
  void initState() {
    _bloc.add(GetRegions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: LocaleText(
          "select_region_title",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is RegisterUserSuccessState) {
            Navigator.of(context).pushNamed(HomeScreenUser.routeName);
            setState(() {
              _isLoading = false;
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: BlocBuilder<RegionsBloc, RegionsState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is RegionsLoadedSuccessState) {
                return SingleChildScrollView(
                  child: BlocBuilder<AuthUserCubit, AuthUserState>(
                    builder: (context, stateCubit) {
                      if (stateCubit is CollectUserData) {
                        user = stateCubit.newUser;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: state.response
                              .map((e) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<AuthUserCubit>()
                                              .getRegionId(
                                                  e.title?.ruRu ?? '', e.id!);

                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 18.h,
                                              width: 18.h,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: state.response.any(
                                                          (element) =>
                                                              context
                                                                  .read<
                                                                      AuthUserCubit>()
                                                                  .newUser
                                                                  .regionId ==
                                                              e.id)
                                                      ? AppColors.primary
                                                      : AppColors.grey),
                                              child: state.response.any(
                                                      (element) =>
                                                          context
                                                              .read<
                                                                  AuthUserCubit>()
                                                              .newUser
                                                              .regionId ==
                                                          e.id)
                                                  ?  Center(
                                                      child: Icon(
                                                        Icons.check,
                                                        size: 10.sp,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                            SizedBox(
                                              width: 9.w,
                                            ),
                                            Text(
                                              e.title?.ruRu ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      const Divider(
                                        color: AppColors.grey,
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
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
              if (context.read<AuthUserCubit>().newUser.userType == "lawyer") {
                Navigator.of(context).pushNamed(LawyerSelectCategory.routeName);
              } else {
                _authBloc.add(RegisterUserEvent(user ?? NewUser()));
                setState(() {
                  _isLoading = true;
                });
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.primary,
            child: _isLoading ? const Center(child: CupertinoActivityIndicator(color: AppColors.white,),) : LocaleText(
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
    );
  }
}
