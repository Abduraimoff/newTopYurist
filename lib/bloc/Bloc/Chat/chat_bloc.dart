import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/Models/chat/chat_response.dart';
import 'package:top_yurist/data/Repositories/ChatRepository.dart';

import '../../../data/Models/chat/chat_message_response.dart';
import '../../../utils/config.dart';


part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repository = ChatRepository();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
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
      ChatMessageResponse? data = ChatMessageResponse();
      try{
        final Response response = await _repository.getChatMessage(chatId: event.chatId);
        data = ChatMessageResponse.fromJson(response.data);
        data.userId = await _storage.read(key: Config.userId);
        emit(ChatMessageLoadedSuccess(data));
      } on DioError catch(e){
        emit(ChatErrorState(e));
      }
    });
    on<SendMessageEvent>((event, emit) async{
      try{
        final Response response = await _repository.sendMessage(chatId: event.chatId, message: event.message, messageType: event.messageType);
        emit(MessageSendSuccess());
      } on DioError catch(e){
        emit(ChatErrorState(e));
      }
    });
  }
}
