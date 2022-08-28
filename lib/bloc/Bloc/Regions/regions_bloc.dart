import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/Models/regions/regions.dart';
import '../../../data/Repositories/RegionsRepository.dart';

part 'regions_event.dart';
part 'regions_state.dart';

class RegionsBloc extends Bloc<RegionsEvent, RegionsState> {
  final RegionsRepository repository = RegionsRepository();
  RegionsBloc() : super(RegionsInitial()) {
    on<RegionsEvent>((event, emit) async{
      try{
        final List<RegionsResponse> response = await repository.getRegions();
        emit(RegionsLoadedSuccessState(response));
      }catch(e){
        emit(RegionsErrorState(e));
      }

    });
  }
}
