part of 'yurist_favourites_list_bloc.dart';

@immutable
abstract class YuristFavEvent extends Equatable{}

class GetYuristFavEvent extends YuristFavEvent{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}



class UnFavoriteYuristEvent extends YuristFavEvent{
  final String? id;

  UnFavoriteYuristEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}
class MakeFavoriteYuristEven extends YuristFavEvent{
  final String? id;

  MakeFavoriteYuristEven(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}