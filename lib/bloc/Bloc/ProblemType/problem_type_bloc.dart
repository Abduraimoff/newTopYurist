import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:top_yurist/data/Repositories/ProblemRepository.dart';

import '../../../data/Models/regions/regions.dart';

part 'problem_type_event.dart';
part 'problem_type_state.dart';

class ProblemTypeBloc extends Bloc<ProblemTypeEvent, ProblemTypeState> {
  final ProblemRepository repository = ProblemRepository();
  ProblemTypeBloc() : super(ProblemTypeInitial()) {
    on<GetProblemsEvent>((event, emit) async{
      try{
        final response = await repository.getProblemTypeList();
        emit(ProblemLoadedSuccess(response));
      }catch(e){
        emit(ProblemErrorState(e));
      }

    });
  }
}
