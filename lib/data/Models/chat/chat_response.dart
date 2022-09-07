// To parse this JSON data, do
//
//     final chatResponse = chatResponseFromJson(jsonString);

import 'dart:convert';

ChatResponse chatResponseFromJson(String str) => ChatResponse.fromJson(json.decode(str));

String chatResponseToJson(ChatResponse data) => json.encode(data.toJson());

class ChatResponse {
  ChatResponse({
    this.total,
    this.data,
  });

  final int? total;
  final List<ChatDatum>? data;

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
    total: json["total"],
    data: List<ChatDatum>.from(json["data"].map((x) => ChatDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChatDatum {
  ChatDatum({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.updatedId,
    this.deleted,
    this.state,
    this.ownerId,
    this.title,
    this.lastMessage,
    this.dialogUserName,
    this.dialogUserPhoto,
    this.unreadCount,
  });

  final String? id;
  final int? createdAt;
  final dynamic updatedAt;
  final dynamic updatedId;
  final bool? deleted;
  final String? state;
  final String? ownerId;
  final String? title;
  final String? lastMessage;
  final String? dialogUserName;
  final String? dialogUserPhoto;
  final int? unreadCount;

  factory ChatDatum.fromJson(Map<String, dynamic> json) => ChatDatum(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    updatedId: json["updated_id"],
    deleted: json["deleted"],
    state: json["state"],
    ownerId: json["owner_id"],
    title: json["title"],
    lastMessage: json["last_message"],
    dialogUserName: json["dialog_user_name"],
    dialogUserPhoto: json["dialog_user_photo"],
    unreadCount: json["unread_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "updated_id": updatedId,
    "deleted": deleted,
    "state": state,
    "owner_id": ownerId,
    "title": title,
    "last_message": lastMessage,
    "dialog_user_name": dialogUserName,
    "dialog_user_photo": dialogUserPhoto,
    "unread_count": unreadCount,
  };
}
