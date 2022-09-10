part of 'user_type_cubit.dart';

abstract class UserTypeState extends Equatable {
  const UserTypeState();
}

class UserTypeInitial extends UserTypeState {
  @override
  List<Object> get props => [];
}
class UserTypeChanged extends UserTypeState{
  final String? userType;

  const UserTypeChanged(this.userType);
  @override
  // TODO: implement props
  List<Object?> get props => [userType];

}