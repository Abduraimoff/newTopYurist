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
          user: const User(
            fullName: 'Феруз Тахирович',
            username: '+998999999999',
            profilePhoto: 'assets/images/lawyer.jpg',
            lawyerState: false,
            userType: UserType.lawyer,
            selectedAmount: 5,
            finishedApplicatoinCount: 6,
            offerAmount: 0,
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
          user: const User(
            fullName: 'Феруз Тахирович',
            username: '+998999999999',
            profilePhoto: 'assets/images/lawyer.jpg',
            lawyerState: false,
            userType: UserType.lawyer,
            selectedAmount: 5,
            finishedApplicatoinCount: 6,
            offerAmount: 0,
          ),
        ),
      ],
      selectedType: 0,
    );
    emit(newState);
  }

  void changeType(int newType) {
    final newstate = (state as Chatloaded).copyWith(selectedType: newType);
    emit(newstate);
  }
}
