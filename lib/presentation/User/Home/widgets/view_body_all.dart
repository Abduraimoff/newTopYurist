import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../bloc/Bloc/Application/application_bloc.dart';
import '../../../../data/Models/user/user_home_request_list.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/base_button.dart';
import '../../Requests/create_new_request.dart';
import '../../Requests/request_detail.dart';
import '../../Requests/widget/requestMainScreen.dart';

class ViewBody extends StatefulWidget {
  final ApplicationBloc? bloc;
  const ViewBody({Key? key, this.bloc}) : super(key: key);
  @override
  State<ViewBody> createState() => _ViewBodyState();
}

class _ViewBodyState extends State<ViewBody> {
  List<UserHomeRequestListResponse>? allData;
  List<UserHomeRequestListResponse>? data;
  List<UserHomeRequestListResponse>? data1;
  final List<String> firstList = ["look","resume","del" ];
  final List<String> secondList = ["look","del" ];
  @override
  void initState() {
    widget.bloc?.add(GetRequestsList());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return BlocConsumer<ApplicationBloc, ApplicationState>(
      bloc: widget.bloc,
      listener: (context, state){
        if(state is ApplicationSuccessfullyDeleted){
          widget.bloc?.add(GetRequestsList());
        }

      },
      builder: (context, state) {
        if (state is ApplicationInitial) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (state is UserRequestsListSuccessState) {
          data = state.response;
          allData = state.response;
        }
        return (data?.isEmpty ?? false)
            ?  UserHomeEmptyPage(bloc: widget.bloc,)
            :  Expanded(
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
                    Container(
                      width: 25.w,
                      child: PopupMenuButton<String>(

                        icon: const Icon(Icons.more_horiz,
                            color: Colors.grey),
                        elevation: 0,


                        onSelected: (String? newValue) {
                          if(newValue == "del"){
                            widget.bloc?.add(ApplicationDeleteEvent(data?[i].id));
                          } else if(newValue == "resume"){
                            widget.bloc?.add(ApplicationResume(data?[i].id??""));
                          }
                        },
                        itemBuilder: (context){
                      return data?[i].state == "PUBLISHED" ? firstList
                          .map<PopupMenuItem<String>>((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: LocaleText(value),
                        );
                      }).toList() : secondList.map<PopupMenuItem<String>>((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: LocaleText(value),
                        );
                      }).toList();
                        }
                      ),
                    ),

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
                              (DateFormat("dd.MM.yyyy", 'en').format(DateTime.fromMicrosecondsSinceEpoch((data?[i].createdAt ?? 0000000000000) * 1000))).toString(),
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
                                          widget.bloc?.add(PublishEvent(
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
                                          elevation: 0, primary: const Color.fromRGBO(
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
        );
      },
    );
  }
}