import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Repositories/UserRepository.dart';

import '../../../data/Models/user/user_home_request_list.dart';
part 'user_home_event.dart';
part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final UserRepository repository = UserRepository();
  UserHomeBloc() : super(UserHomeInitial()) {
    on<GetRequestsList>((event, emit) async{
      try{
        final response = await repository.getUserRequestsList();
        emit(UserRequestsListSuccessState(response));
      }on DioError catch(e){
        if(e.response != null ){
          emit(UserRequestErrorState());
        }
      }
    });
  }
}
