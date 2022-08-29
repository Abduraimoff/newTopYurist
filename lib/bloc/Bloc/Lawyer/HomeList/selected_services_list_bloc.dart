
import 'package:bloc/bloc.dart';
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
            try{
              final response = await repository.getServiceList();
              emit(SelectedServicesListLoadedSuccess(response));
            }catch(e){
              emit(SelectedServicesErrorState(e));

        }

     });
  }
}
