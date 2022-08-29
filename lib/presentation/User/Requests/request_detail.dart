import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_yurist/bloc/Offer/offer_bloc.dart';
import 'package:top_yurist/presentation/User/Requests/lawyer_profile_screen.dart';

import '../../../utils/colors.dart';
import '../../widgets/profileImage.dart';
import 'widget/requestMainScreen.dart';

class UserRequestDetail extends StatefulWidget {
  static const String routeName = "user-request-detail";
  final String? id;
  final String? title;

  const UserRequestDetail({Key? key, this.id, this.title}) : super(key: key);

  @override
  State<UserRequestDetail> createState() => _UserRequestDetailState();
}

class _UserRequestDetailState extends State<UserRequestDetail> {
  Map<String, dynamic>? data;
  int selectedIndex = 0;
  static const List<String> titleList = ["all", "selected", "closed_request"];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.black),
        elevation: 0,
        title: Text(
          widget.title ?? "",
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: const Icon(Icons.filter_list_rounded, color: Colors.black),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 40.h,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 16.w),
              itemBuilder: (context, index) => UserHomeTabbar(
                title: titleList[index],
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                isSelected: selectedIndex == index,
              ),
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemCount: 3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: selectedIndex == 0
                ? DefaultTabView(
                    id: widget.id,
                  )
                : selectedIndex == 1
                    ? DefaultTabView()
                    : DefaultTabView(),
          ),
        ],
      ),
    );
  }
}

class DefaultTabView extends StatelessWidget {
  final String? id;

  DefaultTabView({Key? key, this.id}) : super(key: key);
  final OfferBloc _bloc = OfferBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OfferBloc>(
      create: (context) => OfferBloc()
        ..add(GetOffers({
          "application_id": id,
          "page": 1,
          "size": 100,
        })),
      child: BlocBuilder<OfferBloc, OfferState>(
        builder: (context, state) {
          if (state is OfferSuccessState) {
            return (state.response.data?.isEmpty ?? true)
                ? const Center(
                    child: Text("There is no offer"),
                  )
                : ListView.builder(
                    itemBuilder: (context, i) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.sp)),
                        margin: EdgeInsets.only(
                            left: 16.w, right: 16.w, bottom: 12.h),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        child: ProfileImage(
                                          imageUrl: state.response.data?[i]
                                              .lawyerProfilePhoto,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  UserProfileScreen.routeName, arguments: state.response.data?[i]);
                                            },
                                            child: Text(
                                              state.response.data?[i]
                                                      .lawyerFullName ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                          ),
                                          SizedBox(height: 3.h),
                                          LocaleText(
                                            'verified',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                ?.copyWith(
                                                    color: AppColors.green),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  (state.response.data?[i].isFavorite ?? false)
                                      ? const Icon(
                                          Icons.favorite,
                                          color: AppColors.red,
                                        )
                                      : const Icon(Icons.favorite_outline,
                                          color: Colors.grey)
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "${context.localeString("reviews")}: ${state.response.data?[i].reviewCount ?? 0}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(color: AppColors.grey),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "${context.localeString("solved_request")}: ${state.response.data?[i].doneApplicationCount ?? 0}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(color: AppColors.grey),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "${context.localeString("experience")}: ${state.response.data?[i].workExperience ?? 0}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(color: AppColors.grey),
                              ),
                              Visibility(
                                visible:
                                    state.response.data?[i].isSelected ?? false,
                                child: Container(
                                  height: 23.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1C4FD1)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(58.sp),
                                  ),
                                  child: Center(
                                    child: LocaleText(
                                      "chosen_by_you",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(color: AppColors.primary),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: AppColors.dividerColor,
                              ),
                              Text(
                                "${context.localeString("approximate_price")}: ${state.response.data?[i].offerPrice ?? 0} ${context.localeString("sum")}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(color: AppColors.black),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.response.data?.length ?? 0,
                  );
          }
          if (state is OfferInitial) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
