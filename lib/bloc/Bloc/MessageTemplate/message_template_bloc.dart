import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../data/Models/message_template/message_template.dart';
import '../../../data/Repositories/MessageTemplateRepository.dart';

part 'message_template_event.dart';
part 'message_template_state.dart';

class MessageTemplateBloc extends Bloc<MessageTemplateEvent, MessageTemplateState> {
  final MessageTemplateRepository _repository = MessageTemplateRepository();
  MessageTemplateBloc() : super(MessageTemplateInitial()) {
    on<GetMessageTemplateEvent>((event, emit) async{
      try{
        final Response response = await _repository.getMessageTemplateList();
        emit(MessageTemplateListLoadedState(messageTemplateResponseFromJson(response.data)));
      }on DioError catch(e){
        emit(MessageTemplateErrorState(e.response?.data["error"]));
      }

    });
    on<CreateNewTemplateEvent>((event, emit) async{
      try{
        final Response response = await _repository.createMessageTemplateList(event.description);
        emit(MessageTemplateCreatedSuccessfully());
      }on DioError catch(e){
        emit(MessageTemplateErrorState(e.response?.data["errors"]));
      }

    });
    on<UpdateTemplateEvent>((event, emit) async{
      try{
        final Response response = await _repository.templateUpdated(event.description, event.id);
        emit(TemplateUpdatedSuccessfully());
      }on DioError catch(e){
        emit(MessageTemplateErrorState(e.response?.data["errors"]));
      }

    });
    on<DeleteTemplateEvent>((event, emit) async{
      try{
        final Response response = await _repository.templateDeleted( event.id);
        emit(TemplateDeletedSuccessfully());
      }on DioError catch(e){
        emit(MessageTemplateErrorState(e.response?.data["errors"]));
      }

    });
  }

}
