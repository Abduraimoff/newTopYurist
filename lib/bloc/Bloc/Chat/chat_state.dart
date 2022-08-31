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
class ChatLoadedSuccessState extends ChatState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}