part of 'application_bloc.dart';

@immutable
abstract class ApplicationState  extends Equatable{}

class ApplicationInitial extends ApplicationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ApplicationErrorState extends ApplicationState{
  final Object error;

  ApplicationErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}

class ApplicationCreatedSuccessfullyState extends ApplicationState{
  final CreateApplicationResponse response;

  ApplicationCreatedSuccessfullyState(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}