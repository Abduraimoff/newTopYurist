part of 'user_favorite_bloc.dart';

abstract class UserFavoriteEvent extends Equatable {
  const UserFavoriteEvent();
}

class GetUserFavoriteLawyers extends UserFavoriteEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}