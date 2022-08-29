import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'user_offer_filter_state.dart';

class UserOfferFilterCubit extends Cubit<UserOfferFilterState> {
  UserOfferFilterCubit() : super(UserOfferFilterInitial());
  String? filter;

  void changeFilter(String? newFilter){
    emit(UserOfferFilterInitial());
    filter = newFilter;
    emit(UserFilterChangedState(filter));
  }
}
