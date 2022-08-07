part of 'messaging_bloc.dart';

abstract class MessagingEvent extends Equatable {
  const MessagingEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends MessagingEvent {
  final int userId;
  const InitEvent({
    required this.userId,
  });
}
