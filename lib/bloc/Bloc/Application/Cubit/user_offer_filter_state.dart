part of 'user_offer_filter_cubit.dart';

@immutable
abstract class UserOfferFilterState extends Equatable{}

class UserOfferFilterInitial extends UserOfferFilterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserFilterChangedState extends UserOfferFilterState{
  final String? filter;

  UserFilterChangedState(this.filter);
  @override
  // TODO: implement props
  List<Object?> get props => [filter];
}
