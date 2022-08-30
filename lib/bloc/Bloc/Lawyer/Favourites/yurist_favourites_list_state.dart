part of 'yurist_favourites_list_bloc.dart';


@immutable
abstract class YuristFavState extends Equatable {
  const YuristFavState();
}

class YuristFavListInitial extends YuristFavState {
  @override
  List<Object?> get props => [];
}


class YuristFavLoadedSuccess extends YuristFavState{
  final UserFavoriteResponse response;

  const YuristFavLoadedSuccess(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class YuristFavErrorState extends YuristFavState{
  final String? error;

  const YuristFavErrorState(this.error);
  @override
  List<Object?> get props => [];

}
