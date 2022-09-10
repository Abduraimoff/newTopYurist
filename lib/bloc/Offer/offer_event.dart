part of 'offer_bloc.dart';

abstract class OfferEvent extends Equatable {
  const OfferEvent();
}

class GetOffers extends OfferEvent{
  final Map<String, dynamic> data;
  const GetOffers(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CreateOffer extends OfferEvent{
  final String? id;
  final String? description;
  final String? offerPrice;

  const CreateOffer({required this.id, required this.description, required this.offerPrice});
  @override
  // TODO: implement props
  List<Object?> get props => [id, description, offerPrice];

}
class SelectLawyerEvent extends OfferEvent{
  final String? id;

  const SelectLawyerEvent(this.id);


  @override
  // TODO: implement props
  List<Object?> get props => throw [id];}

class FavouriteEvent extends OfferEvent{
  final String? id;

  const FavouriteEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class UnFavouriteEvent extends OfferEvent{
  final String? id;

  const UnFavouriteEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}