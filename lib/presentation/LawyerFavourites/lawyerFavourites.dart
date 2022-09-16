import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_yurist/bloc/Bloc/Lawyer/Favourites/yurist_favourites_list_bloc.dart';
import 'package:top_yurist/data/Models/user/user_favorite.dart';
import 'package:top_yurist/utils/colors.dart';
import 'package:top_yurist/utils/icons.dart';

class LawyerFavourites extends StatefulWidget {
  const LawyerFavourites({Key? key}) : super(key: key);

  @override
  State<LawyerFavourites> createState() => _LawyerFavouritesState();
}

class _LawyerFavouritesState extends State<LawyerFavourites> {

  final YuristFavBloc _bloc = YuristFavBloc();
  bool isFav = true;
  UserFavoriteResponse? data;

  @override
  void initState() {
    _bloc.add(GetYuristFavEvent(context));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text('Избраное', style: Theme.of(context).textTheme.headline2,),
        ),
        const SizedBox(height: 15,),
        Expanded(
          child: BlocListener(
            bloc: _bloc,
            listener: (context, state) {
              if (state is YuristFavLoadedSuccess) {
                data = state.response;
              }

            },
          child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {

              if(state is YuristFavLoadedSuccess){
                data = state.response;
              }else if (state is UnFavoriteSuccessState){
                _bloc.add(GetYuristFavEvent(context));
              }
              if(state is YuristFavErrorState){
                return Center(child: Text(state.error ?? "Something went wrong"),);
              }
              if(state is YuristFavListInitial){
                return const Center(child: CupertinoActivityIndicator(),);
              }

            return data?.total == 0 ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(child: Text("Your favorites is empty")),
              ],
            ) : ListView.builder(itemBuilder: (context, i){
            return  Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Column(children: [
                ListTile(leading: CircleAvatar(backgroundColor: const Color.fromRGBO(28, 79, 209, 0.1),child: Image.asset('assets/images/userError.png'),
                ),
                  title: Text(data?.data![i]?.fullName ?? "NULL", style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black),),
                  trailing: InkWell(
                      onTap: () {
                        _bloc.add(UnFavoriteYuristEvent(data?.data?[i].id));
                      },
                      child: SvgPicture.asset(AppIcons.heart)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(data?.data![i]?.description ?? "NULL", style: Theme.of(context).textTheme.headline5,),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.location),
                          const SizedBox(width: 10,),
                          Text("Toshkent", style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black), )
                        ],
                      ),
                    Text("15.07.2022", style: Theme.of(context).textTheme.headline5?.copyWith(color: AppColors.black),)
                  ],),
                )
              ],),
            );
          },
          itemCount: data?.data?.length ?? 0,
          );
  },
),
),
        ),
      ],
    ));
  }
}
