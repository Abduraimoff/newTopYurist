import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Models/chat/chat_response.dart';
import 'package:top_yurist/data/Repositories/ChatRepository.dart';

import '../../../data/Models/chat/chat_message_response.dart';


part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repository = ChatRepository();
  ChatBloc() : super(ChatInitial()) {
    on<GetChatsEvent>((event, emit) async{
      try{
        final Response response = await _repository.getChat();
        emit(ChatLoadedSuccess(ChatResponse.fromJson(response.data)));
      } on DioError catch(e){
        emit(ChatErrorState(e));
      }
    });
    on<GetChatsMessageEvent>((event, emit) async{
      try{
        final Response response = await _repository.getChatMessage(chatId: event.chatId);
        emit(ChatMessageLoadedSuccess(ChatMessageResponse.fromJson(response.data)));
      } on DioError catch(e){
        emit(ChatErrorState(e));
      }
    });
  }
}
