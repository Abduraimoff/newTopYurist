import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'problem_type_list_event.dart';
part 'problem_type_list_state.dart';

class ProblemTypeListBloc extends Bloc<ProblemTypeListEvent, ProblemTypeListState> {
  ProblemTypeListBloc() : super(ProblemTypeListInitial()) {
    on<ProblemTypeListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
