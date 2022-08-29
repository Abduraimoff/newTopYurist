
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selected_services_list_event.dart';
part 'selected_services_list_state.dart';

class SelectedServicesListBloc extends Bloc<SelectedServicesListEvent, SelectedServicesListState> {
  SelectedServicesListBloc() : super(SelectedServicesListInitial()) {
    on<SelectedServicesListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
