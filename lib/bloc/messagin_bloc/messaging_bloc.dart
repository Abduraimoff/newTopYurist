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
            user: User(
              id: 7,
              name: 'Феруз Тахирович',
              phoneNumber: '+998999999999',
              image: 'assets/images/lawyer.jpg',
              type: UserType.lawyer,
            ),
          );
          emit(messages);
        }
      },
    );
  }
}
