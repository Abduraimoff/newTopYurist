enum MessageType { text, image }

class Message {
  final int id;
  final String content;
  final DateTime time;
  final MessageType type;
  final bool isSentByMe;
  Message({
    required this.id,
    required this.content,
    required this.time,
    required this.type,
    required this.isSentByMe,
  });

  Message copyWith({
    int? id,
    String? content,
    DateTime? time,
    MessageType? type,
    bool? isSentByMe,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      time: time ?? this.time,
      type: type ?? this.type,
      isSentByMe: isSentByMe ?? this.isSentByMe,
    );
  }
}
