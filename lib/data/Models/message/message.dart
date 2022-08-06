enum MessageType { text, image }

class Message {
  final int id;
  final int userId;
  final String content;
  final DateTime time;
  final MessageType type;
  Message({
    required this.id,
    required this.userId,
    required this.content,
    required this.time,
    required this.type,
  });

  Message copyWith({
    int? id,
    int? userId,
    String? content,
    DateTime? time,
    MessageType? type,
  }) {
    return Message(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      time: time ?? this.time,
      type: type ?? this.type,
    );
  }
}
