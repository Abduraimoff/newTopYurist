

import 'dart:convert';

List<MessageTemplateResponse> messageTemplateResponseFromJson(List str) => (str).map((x) => MessageTemplateResponse.fromJson(x)).toList();

String messageTemplateResponseToJson(List<MessageTemplateResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageTemplateResponse {
  MessageTemplateResponse({
    this.id,
    this.description,
    this.sort,
  });

  final String? id;
  final String? description;
  final int? sort;

  factory MessageTemplateResponse.fromJson(Map<String, dynamic> json) => MessageTemplateResponse(
    id: json["id"],
    description: json["description"],
    sort: json["sort"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "sort": sort,
  };
}
