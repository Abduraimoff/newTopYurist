part of 'messaging_bloc.dart';

abstract class MessagingState extends Equatable {
  const MessagingState();

  @override
  List<Object> get props => [];
}

class MessagingInitial extends MessagingState {
  const MessagingInitial();
}

class MessagingErrorState extends MessagingState {
  const MessagingErrorState();
}

class MessagingLoaded extends MessagingState {
  const MessagingLoaded({
    required this.messages,
    required this.user,
  });
  final List<Message> messages;
  final User user;

  @override
  List<Object> get props => [messages, user];
}
