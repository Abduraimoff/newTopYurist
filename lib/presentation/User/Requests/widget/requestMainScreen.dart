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

class RequestMainScreen extends StatefulWidget {
  const RequestMainScreen({Key? key}) : super(key: key);

  @override
  State<RequestMainScreen> createState() => _RequestMainScreenState();
}

class _RequestMainScreenState extends State<RequestMainScreen> {
  final ApplicationBloc _bloc = ApplicationBloc();
  int selectedIndex = 0;
  List<UserHomeRequestListResponse>? allData;
  List<UserHomeRequestListResponse>? data;
  List<UserHomeRequestListResponse>? data1;
  static const List<String> titleList = ["all", "new", "published"];

  @override
  void initState() {
    _bloc.add(GetRequestsList());
    super.initState();
  }

  void filter(String state) {
    if (data != null) {
      setState(() {
        data1 = allData!.where((element) => element.state == state).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return BlocConsumer<ApplicationBloc, ApplicationState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is ApplicationPublishedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Your application successfully published")));
          _bloc.add(GetRequestsList());
        }
      },
      builder: (context, state) {
        if (state is ApplicationInitial) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is ApplicationErrorState) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
        if (state is UserRequestsListSuccessState) {
          data = state.response;
          allData = state.response;
        }
        return (data?.isEmpty ?? false)
            ? const UserHomeEmptyPage()
            : Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 30,
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
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(CreateNewRequest.routeName)
                                .then((value) => _bloc.add(GetRequestsList()));
                          },
                          child: LocaleText(
                            'create',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                        padding: EdgeInsets.only(left: 16.w),
                        itemBuilder: (context, index) => UserHomeTabbar(
                          title: titleList[index],
                          onPressed: () {
                            if (index == 0) {
                              setState(() {
                                data = allData;
                              });
                            } else if (index == 1) {
                              filter("NEW");
                            } else if (index == 2) {
                              filter("PUBLISHED");
                            }
                            selectedIndex = index;
                          },
                          isSelected: selectedIndex == index,
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 12.w),
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 12.h),
                          itemBuilder: (context, i) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.sp)),
                              child: Container(
                                padding: EdgeInsets.all(16.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserRequestDetail(
                                                            id: data?[i].id,
                                                            title: data?[i]
                                                                .problemType
                                                                ?.ruRu)));
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                data?[i].problemType?.ruRu ??
                                                    "",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(width: 12.w),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5.h),
                                                child: Container(
                                                  width: 16.w,
                                                  height: 16.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xFF1C4FD1),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      '1',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.more_horiz,
                                            color: Colors.grey),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      data?[i].description ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(color: AppColors.grey),
                                      maxLines: 4,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          (data?[i].createdAt ?? "").toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(52),
                                            color: const Color(0xFF2CAD7F)
                                                .withOpacity(0.1),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w,
                                                  vertical: 2.h),
                                              child: Text(
                                                data?[i].state ?? "status",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    ?.copyWith(
                                                        color:
                                                            AppColors.hotToddy),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: data?[i].state == "NEW",
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          const Divider(
                                            color: AppColors.dividerColor,
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          LocaleText(
                                            "you_only_request",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 44.h,
                                                width: 145.w,
                                                child: BaseButton(
                                                    title: 'publish',
                                                    onPressed: () {
                                                      _bloc.add(PublishEvent(
                                                          data?[i].id ?? ""));
                                                    },
                                                    isLoading: false),
                                              ),
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              SizedBox(
                                                  height: 44.h,
                                                  width: 145.w,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              CreateNewRequest
                                                                  .routeName,
                                                              arguments:
                                                                  data?[i]);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 0,
                                                      primary:
                                                          const Color.fromRGBO(
                                                              28, 79, 209, 0.1),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: LocaleText(
                                                      "edit",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5
                                                          ?.copyWith(
                                                              color: AppColors
                                                                  .primary),
                                                    ),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: data?.length ?? 0,
                        ),
                      ),
                    )
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
  const UserHomeEmptyPage({
    Key? key,
  }) : super(key: key);

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
              width: 343.w,
              child: BaseButton(
                  title: 'create_request',
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateNewRequest.routeName);
                  },
                  isLoading: false)),
        ],
      ),
    );
  }
}
