part of 'user_home_bloc.dart';

abstract class UserHomeState extends Equatable {
  const UserHomeState();
}

class UserHomeInitial extends UserHomeState {
  @override
  List<Object> get props => [];
}
class UserRequestErrorState extends UserHomeState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class UserRequestsListSuccessState extends UserHomeState{
  final List<UserHomeRequestListResponse> response;

  const UserRequestsListSuccessState(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}