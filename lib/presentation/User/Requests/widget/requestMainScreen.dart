import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/presentation/User/Requests/create_new_request.dart';
import 'package:top_yurist/presentation/User/Requests/request_detail.dart';
import 'package:top_yurist/presentation/widgets/base_button.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../../../bloc/Bloc/Application/application_bloc.dart';
import '../../../../data/Models/user/user_home_request_list.dart';
import '../../Home/widgets/view_body_all.dart';

class RequestMainScreen extends StatefulWidget {
  const RequestMainScreen({Key? key}) : super(key: key);

  @override
  State<RequestMainScreen> createState() => _RequestMainScreenState();
}

class _RequestMainScreenState extends State<RequestMainScreen> {
  final ApplicationBloc _bloc = ApplicationBloc();
  int selectedIndex = 0;
  List<UserHomeRequestListResponse>? data;
  bool dataIsEmpty = true;

  static const List<String> titleList = ["all", "new", "published"];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return BlocConsumer<ApplicationBloc, ApplicationState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is ApplicationPublishedState) {
          selectedIndex = 0;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Your application successfully published")));
          _bloc.add(GetRequestsList(context));
        } else if (state is ApplicationSuccessfullyDeleted) {
          selectedIndex = 0;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Your application successfully deleted")));
        } else if (state is ApplicationResume) {
          selectedIndex = 0;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Your application successfully Resumed")));
        }
        if (state is ApplicationErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
        if (state is UserRequestsListSuccessState) {
          data = state.response;
          dataIsEmpty = (data?.isEmpty ?? true);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LocaleText(
                    'requests',
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  dataIsEmpty
                      ? TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(CreateNewRequest.routeName)
                                .then((value) =>
                                    _bloc.add(GetRequestsList(context)));
                          },
                          child: LocaleText(
                            'create',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(color: AppColors.primary),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              SizedBox(
                height: dataIsEmpty ? 19.h : 122.h,
              ),
              dataIsEmpty
                  ? SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                        padding: EdgeInsets.only(left: 16.w),
                        itemBuilder: (context, index) => UserHomeTabbar(
                          title: titleList[index],
                          onPressed: () {
                            selectedIndex = index;
                            if (index == 1) {
                              _bloc.add(FilterEvent("NEW"));
                            } else if (index == 2) {
                              _bloc.add(FilterEvent("PUBLISHED"));
                            } else if (index == 0) {
                              _bloc.add(FilterEvent(""));
                            }
                          },
                          isSelected: selectedIndex == index,
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 12.w),
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  : const SizedBox.shrink(),
              ViewBody(
                bloc: _bloc,
              ),
            ],
          ),
        );
      },
    );
  }
}

class UserHomeTabbar extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const UserHomeTabbar(
      {Key? key,
      required this.title,
      required this.isSelected,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 40.h,
          child: Chip(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            label: Center(child: LocaleText(title)),
            backgroundColor:
                isSelected ? AppColors.blue : AppColors.grey.withOpacity(0.1),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.h),
              onTap: onPressed,
            ),
          ),
        )
      ],
    );
  }
}

class UserHomeEmptyPage extends StatelessWidget {
  final ApplicationBloc? bloc;
  const UserHomeEmptyPage({Key? key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/Not Found illustration.png",
            height: 228.h,
            width: 228.w,
          ),
          SizedBox(
            height: 40.h,
          ),
          LocaleText(
            "userHomeEmptyTitle",
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: AppColors.grey),
          ),
          SizedBox(
            height: 24.h,
          ),
          SizedBox(
              height: 46.h,
              width: 260.w,
              child: BaseButton(
                  title: 'create_request',
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(CreateNewRequest.routeName)
                        .then((value) => bloc?.add(GetRequestsList(context)));
                  },
                  isLoading: false)),
        ],
      ),
    );
  }
}
