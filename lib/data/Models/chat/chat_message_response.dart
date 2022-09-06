// To parse this JSON data, do
//
//     final chatMessageResponse = chatMessageResponseFromJson(jsonString);

import 'dart:convert';

ChatMessageResponse chatMessageResponseFromJson(String str) => ChatMessageResponse.fromJson(json.decode(str));

String chatMessageResponseToJson(ChatMessageResponse data) => json.encode(data.toJson());

class ChatMessageResponse {
  ChatMessageResponse({
    this.total,
    this.data,
  });

  final int? total;
  final List<MessageDatum>? data;

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) => ChatMessageResponse(
    total: json["total"],
    data: List<MessageDatum>.from(json["data"].map((x) => MessageDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MessageDatum {
  MessageDatum({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.updatedId,
    this.deleted,
    this.state,
    this.chatId,
    this.senderId,
    this.messageType,
    this.photo,
    this.caption,
    this.text,
  });

  final String? id;
  final int? createdAt;
  final dynamic updatedAt;
  final dynamic updatedId;
  final bool? deleted;
  final String? state;
  final String? chatId;
  final String? senderId;
  final String? messageType;
  final dynamic photo;
  final dynamic caption;
  final String? text;

  factory MessageDatum.fromJson(Map<String, dynamic> json) => MessageDatum(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    updatedId: json["updated_id"],
    deleted: json["deleted"],
    state: json["state"],
    chatId: json["chat_id"],
    senderId: json["sender_id"],
    messageType: json["message_type"],
    photo: json["photo"],
    caption: json["caption"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "updated_id": updatedId,
    "deleted": deleted,
    "state": state,
    "chat_id": chatId,
    "sender_id": senderId,
    "message_type": messageType,
    "photo": photo,
    "caption": caption,
    "text": text,
  };
}
