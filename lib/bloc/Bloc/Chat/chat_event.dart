part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}
class GetChatsEvent extends ChatEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class GetChatsMessageEvent extends ChatEvent{
  final String? chatId;

  const GetChatsMessageEvent(this.chatId);
  @override
  // TODO: implement props
  List<Object?> get props => [chatId];

}

class SendMessageEvent extends ChatEvent{
  final String? lawyerId;
  final String? customerId;
  final String? message;

  const SendMessageEvent({this.lawyerId, this.customerId, this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [lawyerId, customerId, message];

}