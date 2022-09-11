part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}
class ChatErrorState extends ChatState{
  final Object error;

  const ChatErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}
class SentMessageSuccessState extends ChatState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ChatLoadedSuccess extends ChatState{
  final ChatResponse response;

  const ChatLoadedSuccess(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}

class ChatMessageLoadedSuccess extends ChatState{
  final ChatMessageResponse response;

  const ChatMessageLoadedSuccess(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}
class MessageSendSuccess extends ChatState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class PhotoSendSuccess extends ChatState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}