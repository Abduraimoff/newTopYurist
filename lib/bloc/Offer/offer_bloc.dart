import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Repositories/OfferRepository.dart';

import '../../data/Models/offers/offer_list_response.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final OfferRepository repository = OfferRepository();
  OfferBloc() : super(OfferInitial()) {
    on<GetOffers>((event, emit) async{
      try{
        final Response response = await repository.getOfferList(event.data);
        if(response.statusCode == 200){
          emit(OfferSuccessState(OfferListResponse.fromJson(response.data)));
        } else{
          emit(OfferErrorState());
        }
      }on DioError catch(e){
        emit(OfferErrorState());
      }

    });
    on<CreateOffer>((event, emit) async{
      try{
        final Response response = await repository.createOffer(id: event.id, description: event.description, price: event.offerPrice);
          emit(OfferSuccessfullySend());
      }on DioError catch(e){
        emit(OfferErrorState());
      }

    });
    on<SelectLawyerEvent>((event, emit) async{
      try{
        final Response response = await repository.selectLawyer(id: event.id,);
        emit(SelectLawyerState());
      }on DioError catch(e){
        emit(OfferErrorState());
      }

    });
  }
}
