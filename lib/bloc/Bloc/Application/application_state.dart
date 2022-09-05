part of 'application_bloc.dart';

@immutable
abstract class ApplicationState  extends Equatable{}

class ApplicationInitial extends ApplicationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
  class ApplicationLoading extends ApplicationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ApplicationErrorState extends ApplicationState{
  final String error;

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

class ApplicationPublishedState extends ApplicationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UserRequestsListSuccessState extends ApplicationState{
  final List<UserHomeRequestListResponse>? response;

   UserRequestsListSuccessState(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class ApplicationSuccessfullyDeleted extends ApplicationState{
  final PublishApplication response;

  ApplicationSuccessfullyDeleted(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}
class ApplicationResumedSuccessFully extends ApplicationState{
  final PublishApplication response;

  ApplicationResumedSuccessFully(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}
class  ApplicationSuccessfullyAddedToFavourite extends ApplicationState{
  final PublishApplication response;

  ApplicationSuccessfullyAddedToFavourite(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}