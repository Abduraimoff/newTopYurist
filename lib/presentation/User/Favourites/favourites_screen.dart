import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/presentation/widgets/profileImage.dart';

import '../../../bloc/Bloc/UserFavorite/user_favorite_bloc.dart';
import '../../../data/Models/user/user_favorite.dart';

class FavouritesScreen extends StatefulWidget {
   const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  UserFavoriteResponse? data = UserFavoriteResponse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Избраное',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.black),
            ),
            const SizedBox(height: 16),
            BlocProvider<UserFavoriteBloc>(
              create: (context) => UserFavoriteBloc()..add(GetUserFavoriteLawyers()),
              child: BlocConsumer<UserFavoriteBloc, UserFavoriteState>(
                listener: (context, state){
                  if(state is UnFavoriteSuccessState){
                    BlocProvider.of<UserFavoriteBloc>(context).add(GetUserFavoriteLawyers());
                  }
                },
                builder: (context, state) {
                  if(state is UserFavoriteLoadedSuccessState){
                    data = state.response;
                    }
                  if(state is UserFavoriteErrorState){
                    return Center(child: Text(state.error ?? "Something went wrong"),);
                  }
                  if(state is UserFavoriteInitial){
                    return const Center(child: CupertinoActivityIndicator(),);
                  }
                  return data?.total == 0 ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Center(child: Text("Your favorites is empty")),
                    ],
                  ): Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, i) {
                            return Card(
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
                                           CircleAvatar(child: ProfileImage(imageUrl: data?.data?[i].profilePhoto, height: 32.w, width: 32,),),
                                             SizedBox(width: 12.w),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children:  [
                                                Text(
                                                  data?.data?[i].fullName ?? "",
                                                  style:  TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h),
                                                Text(
                                                  data?.data?[i].lawyerState ??"",
                                                  style:  TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                         IconButton(onPressed: (){
                                           BlocProvider.of<UserFavoriteBloc>(context).add(UnFavoriteLawyerEvent(data?.data?[i].id));
                                         }, icon: SvgPicture.asset("assets/svg/heart.svg"))
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    const Divider(color: Colors.grey),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children:  [
                                        Text(
                                          'Стаж: ${data?.data?[i].workExperience} лет',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Отзывов: ${data?.data?[i].reviewCount}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: data?.total,
                        ));



                },

              ),
            )
          ],
        ),
      )),
    );
  }
}
