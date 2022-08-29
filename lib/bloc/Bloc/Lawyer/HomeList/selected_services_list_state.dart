part of 'selected_services_list_bloc.dart';


@immutable
abstract class SelectedServicesListState extends Equatable{}

class SelectedServicesListInitial extends SelectedServicesListState {
  @override
  List<Object?> get props => [];
}

class SelectedServicesListLoadedSuccess extends SelectedServicesListState{
  final List<RegionsResponse> response;

  SelectedServicesListLoadedSuccess(this.response);
  @override
  List<Object?> get props => [response];

}

class SelectedServicesErrorState extends SelectedServicesListState{
  final Object error;

  SelectedServicesErrorState(this.error);
  @override
  List<Object?> get props => [];

}
