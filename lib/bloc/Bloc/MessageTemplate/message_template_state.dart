part of 'message_template_bloc.dart';

abstract class MessageTemplateState extends Equatable {
  const MessageTemplateState();
}

class MessageTemplateInitial extends MessageTemplateState {
  @override
  List<Object> get props => [];
}
class MessageTemplateErrorState extends MessageTemplateState{
  final String error;

  const MessageTemplateErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class MessageTemplateListLoadedState extends MessageTemplateState{
  final List<MessageTemplateResponse> response;

  const MessageTemplateListLoadedState(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}

class MessageTemplateCreatedSuccessfully extends MessageTemplateState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class TemplateUpdatedSuccessfully extends MessageTemplateState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TemplateDeletedSuccessfully extends MessageTemplateState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}