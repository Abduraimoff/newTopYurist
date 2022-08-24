part of 'user_home_bloc.dart';

abstract class UserHomeEvent extends Equatable {
  const UserHomeEvent();
}
class GetRequestsList extends UserHomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}