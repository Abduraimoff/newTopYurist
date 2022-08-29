import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/bloc/Bloc/Lawyer/HomeList/selected_services_list_bloc.dart';

import 'package:top_yurist/presentation/Services/select_category.dart';
import 'package:top_yurist/presentation/Services/service_detail.dart';
import 'package:top_yurist/utils/colors.dart';

import '../UserUploadedServices/LawyerChatScreen.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final SelectedServicesListBloc _bloc = SelectedServicesListBloc();

  @override
  void initState() {
    _bloc.add(GetSelectedServicesEvent());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      body: BlocListener<SelectedServicesListBloc, SelectedServicesListState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is SelectedServicesListLoadedSuccess) {

          }
        },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                'Услуги',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                height: 46.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primary.withOpacity(0.1)),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SelectCategory.routeName);
                  },
                  child: const Text(
                    'Выбрать категорию',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
            BlocBuilder<SelectedServicesListBloc, SelectedServicesListState>(
            bloc: _bloc,
            builder: (context, state) {
            if (state is SelectedServicesListLoadedSuccess) {
            return Expanded(
                  child: ListView.builder(

                itemBuilder: (context, i) {

                  return Card(
                    margin: EdgeInsets.only(bottom: 12.h),
                    // shadowColor: AppColors.shadow,

                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),

                    ),
                    color: AppColors.white,
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      LawyerChatScreen.routeName);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          // state.response![i].,
                                          state.response[i].title?.ruRu ?? "NULL",

                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        SizedBox(width: 6.w),
                                        // Container(
                                        //   width: 16.w,
                                        //   height: 16.h,
                                        //   decoration: const BoxDecoration(
                                        //     shape: BoxShape.circle,
                                        //     color: AppColors.primary,
                                        //   ),
                                        //   child: const Center(
                                        //     child: Text(
                                        //       '1',
                                        //       style: TextStyle(
                                        //           color: Colors.white),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(height: 12.h),
                                    Text(
                                      'Количество запросов: ${state.response[i].application_count!}' ,
                                      style:
                                      Theme
                                          .of(context)
                                          .textTheme
                                          .headline5,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    //remove category
                                  },
                                  child: SvgPicture.asset("assets/svg/trash.svg")),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: state.response.length,
              ));
    }
    return const Center(child: CircularProgressIndicator());
  },
)
            ],
          ),
        ),
      ),
),
    );
  }
}
