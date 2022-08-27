import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Models/message/message.dart';
import 'package:top_yurist/data/Models/user/user.dart';

part 'messaging_event.dart';
part 'messaging_state.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  MessagingBloc() : super(const MessagingInitial()) {
    on<MessagingEvent>((event, emit) {
      switch (event) {
      }
    });
    on<InitEvent>(
      (event, emit) async {
        await Future.delayed(const Duration(milliseconds: 300));
        if (state is MessagingInitial) {
          final messages = MessagingLoaded(
            messages: [
              Message(
                id: 3,
                content:
                    'Нужна консультация юриста по уголовному праву Цену можем обговорить лично, примерную стоимость за консультицию и защиту по делу в суде',
                time: DateTime.parse('2022-07-20'),
                type: MessageType.text,
                isSentByMe: false,
              ),
              Message(
                id: 4,
                content:
                    'Нужна консультация юриста по уголовному праву Цену можем обговорить лично, примерную стоимость за консультицию и защиту по делу в суде',
                time: DateTime.now(),
                type: MessageType.text,
                isSentByMe: true,
              ),
            ],
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
          );
          emit(messages);
        }
      },
    );
  }
}
