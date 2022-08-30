
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:top_yurist/data/Repositories/LawyerFavRepository.dart';

import '../../../../data/Models/Lawyer/lawyer_select_service_detail.dart';
import '../../../../data/Repositories/ProblemTypeListRepository.dart';

part 'problem_type_list_event.dart';
part 'problem_type_list_state.dart';

class ProblemTypeListBloc extends Bloc<ProblemTypeListEvent, ProblemTypeListState> {
  final ProblemTypeListRepository repository = ProblemTypeListRepository();
  final LawyerFavRepository repository2 = LawyerFavRepository();

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

    on<UnFavoriteYuristEvent>((event, emit) async{
      try{
        final Response response = await repository2.removeToFavourite(event.id);
        emit(UnFavoriteSuccessState(response));
      } on DioError catch (e){
        if(e.response != null){
          emit(ProblemTypeListErrorState(e.response?.data["errors"]));
        } else{
          emit(ProblemTypeListErrorState(e.message));
        }

      }
    });

    on<MakeFavoriteYuristEven>((event, emit) async{
      try{
        final Response response = await repository2.addToFavourite(event.id);
        emit(MakeFavoriteSuccessState(response));
      } on DioError catch (e){
        if(e.response != null){
          emit(ProblemTypeListErrorState(e.response?.data["errors"]));
        } else{
          emit(ProblemTypeListErrorState(e.message));
        }

      }
    });



  }
}
