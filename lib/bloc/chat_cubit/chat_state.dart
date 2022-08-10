part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class Chatloaded extends ChatState {
  Chatloaded({required this.chats, required this.selectedType});
  final List<Chat> chats;
  final int selectedType;
  final types = ['all', 'resolved', 'not_resolved'];

  @override
  List<Object> get props => [chats, selectedType];

  Chatloaded copyWith({
    List<Chat>? chats,
    int? selectedType,
  }) {
    return Chatloaded(
      chats: chats ?? this.chats,
      selectedType: selectedType ?? this.selectedType,
    );
  }
}
