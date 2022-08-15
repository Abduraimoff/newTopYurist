part of 'auth_user_cubit.dart';

@immutable
abstract class AuthUserState extends Equatable{}

class AuthUserInitial extends AuthUserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CollectUserData extends AuthUserState{
  final NewUser newUser;

  CollectUserData(this.newUser);
  @override
  // TODO: implement props
  List<Object?> get props => [newUser];

}
