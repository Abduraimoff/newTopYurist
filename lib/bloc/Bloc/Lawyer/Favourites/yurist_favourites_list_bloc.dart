
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:top_yurist/data/Models/user/user_favorite.dart';
import 'package:top_yurist/data/Repositories/LawyerFavRepository.dart';
part 'yurist_favourites_list_event.dart';
part 'yurist_favourites_list_state.dart';

class YuristFavBloc extends Bloc<YuristFavEvent, YuristFavState> {
  YuristFavBloc() : super(YuristFavListInitial()) {
    final LawyerFavRepository repository = LawyerFavRepository();

        on<YuristFavEvent>((event, emit) async {
          emit(YuristFavListInitial());
              try{
                final Response response = await repository.getFavList();
                emit(YuristFavLoadedSuccess(UserFavoriteResponse.fromJson(response.data)));
              } on DioError catch (e){
                if(e.response != null){
                  emit(YuristFavErrorState(e.response?.data["errors"]));
                } else{
                  emit(YuristFavErrorState(e.message));
                }

              }
            });

        }

}
