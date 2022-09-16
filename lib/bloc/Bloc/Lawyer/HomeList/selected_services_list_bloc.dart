
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:top_yurist/data/Models/regions/regions.dart';
import 'package:top_yurist/data/Repositories/LawyerServiceRepository.dart';
import 'package:top_yurist/presentation/Login/login_screen.dart';
part 'selected_services_list_event.dart';
part 'selected_services_list_state.dart';

class SelectedServicesListBloc extends Bloc<SelectedServicesListEvent, SelectedServicesListState> {
  SelectedServicesListBloc() : super(SelectedServicesListInitial()) {
    final LawyerServiceRepository repository = LawyerServiceRepository();

        on<GetSelectedServicesEvent>((event, emit) async {
          emit(SelectedServicesListInitial());
            try{
              final response = await repository.getServiceList();
              emit(SelectedServicesListLoadedSuccess(response));
            }on DioError catch(e){
              if(e.response?.statusCode == 401){
                Navigator.of(event.context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
                await  const FlutterSecureStorage().deleteAll();
              }
              emit(SelectedServicesErrorState(e));

        }

     });
    on<GetRemoveServiceEvent>((event, emit) async {
      try{
        final response = await repository.removeService(event.ids);
        emit(SuccessfullyRemovedState());
      }on DioError catch(e){
        emit(SelectedServicesErrorState(e));

      }

    });
    on<AddServiceEvent>((event, emit) async {
      try{
        final response = await repository.addService(event.ids);
        emit(SuccessFullyAddedState());
      }on DioError catch(e){
        emit(SelectedServicesErrorState(e));

      }

    });
  }
}
