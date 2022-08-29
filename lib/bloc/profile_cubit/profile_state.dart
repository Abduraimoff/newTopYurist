part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class UserState extends ProfileState {
  const UserState({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class ProfileErrorState extends ProfileState {
  const ProfileErrorState(this.errorText);
  final String errorText;
}
