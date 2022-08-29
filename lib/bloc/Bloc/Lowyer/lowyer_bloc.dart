import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lowyer_event.dart';
part 'lowyer_state.dart';

class LowyerBloc extends Bloc<LowyerEvent, LowyerState> {
  LowyerBloc() : super(LowyerInitial()) {
    on<LowyerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
