import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:top_yurist/data/Repositories/ApplicationRepository.dart';

import '../../../data/Models/application/create_application_response.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final ApplicationRepository repository = ApplicationRepository();
  ApplicationBloc() : super(ApplicationInitial()) {
    on<CreateApplicationEvent>((event, emit) async{
        try{
          final response = await repository.createApplication(event.data);
        }on DioError catch(e){
          if(e.response != null){
            emit(ApplicationErrorState(e.response?.data["error"]));
          }
        }
    });
  }
}
