part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}
class GetChatsEvent extends ChatEvent{
  final String? state;

  const GetChatsEvent(this.state);
  @override
  // TODO: implement props
  List<Object?> get props => [state];

}
class GetChatsMessageEvent extends ChatEvent{
  final String? chatId;

  const GetChatsMessageEvent(this.chatId);
  @override
  // TODO: implement props
  List<Object?> get props => [chatId];

}

class SendMessageEvent extends ChatEvent{
  final String? chatId;
  final String? message;
  final String? messageType;

  const SendMessageEvent({this.chatId, this.message, this.messageType});
  @override
  // TODO: implement props
  List<Object?> get props => [chatId, messageType, message];

}

class SendPhotoEvent extends ChatEvent{
  final Map<String, String>? data;
  final String? chatId;

  const SendPhotoEvent({this.data, this.chatId});
  @override
  // TODO: implement props
  List<Object?> get props => [data, chatId];

}