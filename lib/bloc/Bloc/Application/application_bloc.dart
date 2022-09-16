import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:top_yurist/data/Repositories/ApplicationRepository.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';

import '../../../data/Models/application/create_application_response.dart';
import '../../../data/Models/application/publish_aplication.dart';
import '../../../data/Models/user/user_home_request_list.dart';

part 'application_event.dart';
part 'application_state.dart';


class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final ApplicationRepository repository = ApplicationRepository();
   List<UserHomeRequestListResponse>? data = [];
  ApplicationBloc() : super(ApplicationInitial()) {
    on<GetRequestsList>((event, emit) async{
      try{
        emit(ApplicationLoading());
        final response = await repository.getUserRequestsList();
        data = response;
        emit(UserRequestsListSuccessState(response));
      }on DioError catch(e){
        if(e.response?.statusCode == 401){
          Navigator.of(event.context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
          await const FlutterSecureStorage().deleteAll();
        }
        if(e.response != null ){
          emit(ApplicationErrorState(e.response?.data["error"]));
        }
      }
    });
    on<CreateApplicationEvent>((event, emit) async{
        try{
          final response = await repository.createApplication(event.data);
          emit(ApplicationCreatedSuccessfullyState(response));
        }on DioError catch(e){
          if(e.response != null){
            emit(ApplicationErrorState(e.response?.data["error"]));
          }
        }
    });
    on<UpdateApplicationEvent>((event, emit) async{
      try{
        final response = await repository.updateApplication(event.data, event.id);
        emit(ApplicationCreatedSuccessfullyState(response));
      }on DioError catch(e){
        if(e.response != null){
          emit(ApplicationErrorState(e.response?.data["error"]));
        }
      }
    });
    on<PublishEvent>((event, emit) async{
      try{
        final response = await repository.publishApplication(event.id);
        emit(ApplicationPublishedState());
      }on DioError catch(e){
        if(e.response != null){
          emit(ApplicationErrorState(e.response?.data["error"]));
        }
      }
    });
    on<FilterEvent>((event, emit){
      emit(ApplicationInitial());
      final filteredData = data?.where((element) => element.state == event.state).toList();
      emit(UserRequestsListSuccessState(event.state == ""? data: filteredData));
    });
    on<ApplicationDeleteEvent>((event, emit) async{
      try{
        final response = await repository.applicationDelete(event.id);
        emit(ApplicationSuccessfullyDeleted(response));
      }on DioError catch(e){
        if(e.response != null){
          emit(ApplicationErrorState(e.response?.data["error"]));
        }
      }
    });
    on<ApplicationResume>((event, emit) async{
      try{
        final response = await repository.applicationResumed(event.id);
        emit(ApplicationResumedSuccessFully(response));
      }on DioError catch(e){
        if(e.response != null){
          emit(ApplicationErrorState(e.response?.data["error"]));
        }
      }
    });
    on<ApplicationAddFavouriteEvent>((event, emit) async{
      try{
        final response = await repository.applicationAddedToFavourite(event.id);
        emit(ApplicationSuccessfullyAddedToFavourite(response));
      }on DioError catch(e){
        if(e.response != null){
          emit(ApplicationErrorState(e.response?.data["error"]));
        }
      }
    });
  }
}
