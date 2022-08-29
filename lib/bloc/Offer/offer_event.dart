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
