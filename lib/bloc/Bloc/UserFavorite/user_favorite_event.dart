part of 'user_favorite_bloc.dart';

abstract class UserFavoriteEvent extends Equatable {
  const UserFavoriteEvent();
}

class GetUserFavoriteLawyers extends UserFavoriteEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UnFavoriteLawyerEvent extends UserFavoriteEvent{
  final String? id;

  const UnFavoriteLawyerEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}
class MakeFavoriteLawyerEvent extends UserFavoriteEvent{
  final String? id;

  const MakeFavoriteLawyerEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}
