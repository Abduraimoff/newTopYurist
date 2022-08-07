part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class Chatloaded extends ChatState {
  final List<Chat> chats;
  const Chatloaded({required this.chats});

  @override
  List<Object> get props => [chats];
}
