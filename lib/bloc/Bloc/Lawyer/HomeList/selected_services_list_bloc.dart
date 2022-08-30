
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:top_yurist/data/Models/regions/regions.dart';
import 'package:top_yurist/data/Repositories/LawyerServiceRepository.dart';
part 'selected_services_list_event.dart';
part 'selected_services_list_state.dart';

class SelectedServicesListBloc extends Bloc<SelectedServicesListEvent, SelectedServicesListState> {
  SelectedServicesListBloc() : super(SelectedServicesListInitial()) {
    final LawyerServiceRepository repository = LawyerServiceRepository();

        on<SelectedServicesListEvent>((event, emit) async {
          emit(SelectedServicesListInitial());
            try{
              final response = await repository.getServiceList();
              emit(SelectedServicesListLoadedSuccess(response));
            }catch(e){
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
