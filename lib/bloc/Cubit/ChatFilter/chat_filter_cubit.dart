import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_filter_state.dart';

class ChatFilterCubit extends Cubit<int> {
  ChatFilterCubit() : super(0);
  int index = 0;
  void changeIndex(int i){
    index = i;
    emit(index);
  }
}
