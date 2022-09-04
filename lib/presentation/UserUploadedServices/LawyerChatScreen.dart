import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:top_yurist/presentation/UserUploadedServices/uploaded_service_detail.dart';
import 'package:top_yurist/presentation/widgets/profileImage.dart';
import 'package:top_yurist/utils/colors.dart';

import '../../bloc/Bloc/Lawyer/LawyerProblemTypeList/problem_type_list_bloc.dart';
import '../../data/Models/Lawyer/lawyer_select_service_detail.dart';
import '../../utils/icons.dart';
import '../User/Requests/widget/requestMainScreen.dart';
import 'filter_by_city.dart';

class LawyerChatScreen extends StatefulWidget {
  static const String routeName = "lawyer/chat/screen";

  const LawyerChatScreen({Key? key}) : super(key: key);

  @override
  State<LawyerChatScreen> createState() => _LawyerChatScreenState();
}

class _LawyerChatScreenState extends State<LawyerChatScreen>
    with SingleTickerProviderStateMixin {
  static const List<String> titleList = ["all", "new", "published"];
  final ProblemTypeListBloc _bloc = ProblemTypeListBloc();
  int selectedIndex = 0;
  LawyerSelectServiceDetailResponse? loadedData;
  Map<String, dynamic>? data;
  int? regionId;
  ValueChanged<int>? filterByRegion(int? id){
   regionId = id;

  }

  @override
  void didChangeDependencies() {
    data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _bloc.add(GetProblemListEvent(problemTypeId: data?["problemId"], regionId: regionId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.grey),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          data?["title"],
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 2.4,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => FilterByCity(onChanged: filterByRegion,))).then((value) => _bloc.add(GetProblemListEvent(problemTypeId: data?["problemId"], regionId: regionId)));
            },
            padding: EdgeInsets.only(right: 16.w),
            icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<ProblemTypeListBloc, ProblemTypeListState>(
            bloc: _bloc,
            listener: (context, state) {
            if (state is MakeFavoriteSuccessState ||
                state is UnFavoriteSuccessState) {
              _bloc.add(
                  GetProblemListEvent(problemTypeId: data?["problemId"]));
            }
          },
          builder: (context, state) {
            if (state is ProblemTypeListInitial) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is ProblemTypeListLoadedStat) {
              loadedData = state.response;
            }
            return (loadedData?.data?.isEmpty ?? true) ? Center(child: Text("There are no application "),) : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 25.h),
                SizedBox(
                  height: 40.h,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 16.w),
                    itemBuilder: (context, index) => UserHomeTabbar(
                      title: titleList[index],
                      onPressed: () {
                        selectedIndex = index;
                        if (index == 1) {
                        } else if (index == 2) {
                        } else if (index == 0) {}
                      },
                      isSelected: selectedIndex == index,
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(width: 12.w),
                    itemCount: titleList.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                 SizedBox(height: 20.h),
                Expanded(
                  child: newCard(loadedData),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget newCard(LawyerSelectServiceDetailResponse? data) {
    return ListView.builder(
      itemBuilder: (context, i) {
        return SizedBox(
          child: Card(
            child: Padding(
              padding:  EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            child: ProfileImage(
                              imageUrl: data?.data?[i].ownerProfilePhoto,
                              height: 32.w,
                              width: 32.w,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  UploadedServiceDetail.routeName,
                                  arguments: data?.data?[i]);
                            },
                            child: Text(
                              data?.data?[i].ownerFullName ?? "",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            data?.data?[i].isFavorite ?? false
                                ? _bloc.add(
                                    UnFavoriteYuristEvent(data?.data?[i].id))
                                : _bloc.add(
                                    MakeFavoriteYuristEven(data?.data?[i].id));
                          },
                          child: SvgPicture.asset(
                              data?.data?[i].isFavorite ?? false
                                  ? AppIcons.heart
                                  : AppIcons.heartOutlined))
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    data?.data?[i].description ?? "",
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 2,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children:  [
                          const Icon(Icons.location_on_outlined),
                          Text(data?.data?[i].regionTitle?.ruRu ?? "" , style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black),)
                        ],
                      ),
                       Text(DateFormat("dd.MM.yyyy", 'en').format(DateTime.fromMicrosecondsSinceEpoch((data?.data?[i].createdAt ?? 0000000000000) * 1000))),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: data?.total ?? 0,
    );
  }
}
