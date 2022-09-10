part of 'offer_bloc.dart';

abstract class OfferState extends Equatable {
  const OfferState();
}

class OfferInitial extends OfferState {
  @override
  List<Object> get props => [];
}
class OfferErrorState extends OfferState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class OfferSuccessState extends OfferState{
  final OfferListResponse response;

  const OfferSuccessState(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}

class OfferSuccessfullySend extends OfferState{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class SelectLawyerState extends OfferState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class FavouriteState extends OfferState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}