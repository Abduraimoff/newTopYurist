import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';

import '../../../data/Models/user/user_favorite.dart';
import '../../../data/Repositories/user_favorite_repository.dart';

part 'user_favorite_event.dart';
part 'user_favorite_state.dart';

class UserFavoriteBloc extends Bloc<UserFavoriteEvent, UserFavoriteState> {
  final UserFavoriteRepository repository = UserFavoriteRepository();
  UserFavoriteBloc() : super(UserFavoriteInitial()) {
    on<GetUserFavoriteLawyers>((event, emit) async{
    try{
      final Response response = await repository.getUserFavoriteLowyerList();
      emit(UserFavoriteLoadedSuccessState(UserFavoriteResponse.fromJson(response.data)));
    } on DioError catch (e){
      if(e.response?.statusCode == 401){
        Navigator.of(event.context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      }
      if(e.response != null){
        emit(UserFavoriteErrorState(e.response?.data["errors"]));
      } else{
        emit(UserFavoriteErrorState(e.message));
      }

    }
    });
    on<UnFavoriteLawyerEvent>((event, emit) async{
      try{
        final Response response = await repository.unFavoriteLawyer(event.id);
        emit(UnFavoriteSuccessState());
      } on DioError catch (e){
        if(e.response != null){
          emit(UserFavoriteErrorState(e.response?.data["errors"]));
        } else{
          emit(UserFavoriteErrorState(e.message));
        }

      }
    });
  }
}
