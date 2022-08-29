import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

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
    }catch (e){

    }
    });
  }
}
