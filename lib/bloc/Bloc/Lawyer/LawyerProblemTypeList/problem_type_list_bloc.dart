import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';

import '../../../../data/Models/Lawyer/lawyer_select_service_detail.dart';
import '../../../../data/Repositories/ProblemTypeListRepository.dart';

part 'problem_type_list_event.dart';
part 'problem_type_list_state.dart';

class ProblemTypeListBloc extends Bloc<ProblemTypeListEvent, ProblemTypeListState> {
  final ProblemTypeListRepository repository = ProblemTypeListRepository();
  ProblemTypeListBloc() : super(ProblemTypeListInitial()) {
    on<GetProblemListEvent>((event, emit) async {

 try{
   print(event.problemTypeId);
   final Response response = await repository.getProblems(regionId: event.regionId, problemT: event.problemTypeId);
   emit(ProblemTypeListLoadedStat(LawyerSelectServiceDetailResponse.fromJson(response.data)));

 } on DioError catch(e){
   emit(ProblemTypeListErrorState(e.response?.data["error"]));
 }

    });
  }
}
