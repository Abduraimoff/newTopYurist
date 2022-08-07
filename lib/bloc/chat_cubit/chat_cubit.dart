import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Models/chat/chat.dart';
import 'package:top_yurist/data/Models/user/user.dart';

import '../../data/Models/message/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {
    getChats();
  }

  Future<void> getChats() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newState = Chatloaded(
      chats: [
        Chat(
          id: 0,
          lastMessage: Message(
            id: 0,
            content:
                'Нужна консультация юриста по уголовному праву Цену можем обговорить лично, примерную стоимость за консультицию и защиту по делу в суде',
            time: DateTime.now(),
            type: MessageType.text,
            isSentByMe: true,
          ),
          isResolved: true,
          user: User(
            id: 5,
            name: 'Феруз Тахирович',
            phoneNumber: '+998999999999',
            image: 'assets/images/lawyer.jpg',
            type: UserType.lawyer,
          ),
        ),
        Chat(
          id: 1,
          lastMessage: Message(
            id: 1,
            content:
                'Нужна консультация юриста по уголовному праву Цену можем обговорить лично, примерную стоимость за консультицию и защиту по делу в суде',
            time: DateTime.now(),
            type: MessageType.text,
            isSentByMe: true,
          ),
          isResolved: true,
          user: User(
            id: 6,
            name: 'Феруз Тахирович',
            phoneNumber: '+998999999999',
            image: 'assets/images/lawyer.jpg',
            type: UserType.lawyer,
          ),
        ),
      ],
    );
    emit(newState);
  }
}
