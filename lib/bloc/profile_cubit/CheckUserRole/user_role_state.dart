part of 'user_role_cubit.dart';

@immutable
abstract class UserRoleState {}

class UserRoleInitial extends UserRoleState {}

class UserRoleChanged extends UserRoleState{
  final String? user;

  UserRoleChanged(this.user);
}