part of 'user_favorite_bloc.dart';

abstract class UserFavoriteState extends Equatable {
  const UserFavoriteState();
}

class UserFavoriteInitial extends UserFavoriteState {
  @override
  List<Object> get props => [];
}
class UserFavoriteErrorState extends UserFavoriteState{
  final String? error;

  const UserFavoriteErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}
class UserFavoriteLoadedSuccessState extends UserFavoriteState{
  final UserFavoriteResponse response;

  const UserFavoriteLoadedSuccessState(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UnFavoriteSuccessState extends UserFavoriteState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class MakeFavoriteSuccessState extends UserFavoriteState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}