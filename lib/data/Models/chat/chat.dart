import 'package:top_yurist/data/Models/message/message.dart';
import 'package:top_yurist/data/Models/user/user.dart';

class Chat {
  final int id;
  final User user;
  final Message lastMessage;
  final bool isResolved;
  Chat({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.isResolved,
  });

  Chat copyWith({
    int? id,
    User? user,
    Message? lastMessage,
    bool? isResolved,
  }) {
    return Chat(
      id: id ?? this.id,
      user: user ?? this.user,
      lastMessage: lastMessage ?? this.lastMessage,
      isResolved: isResolved ?? this.isResolved,
    );
  }
}
