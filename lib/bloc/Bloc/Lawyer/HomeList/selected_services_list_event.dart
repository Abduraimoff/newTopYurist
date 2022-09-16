part of 'selected_services_list_bloc.dart';

@immutable
abstract class SelectedServicesListEvent extends Equatable{}

class GetSelectedServicesEvent extends SelectedServicesListEvent{
  final BuildContext context;

  GetSelectedServicesEvent(this.context);
  @override
  // TODO: implement props
  List<Object?> get props => [context];
}

class GetRemoveServiceEvent extends SelectedServicesListEvent{
  final List<String> ids;

  GetRemoveServiceEvent(this.ids);
  @override
  // TODO: implement props
  List<Object?> get props => [ids];

}

class AddServiceEvent extends SelectedServicesListEvent{
  final List<String> ids;

  AddServiceEvent(this.ids);
  @override
  // TODO: implement props
  List<Object?> get props => [ids];

}