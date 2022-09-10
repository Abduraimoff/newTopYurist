// To parse this JSON data, do
//
//     final userHomeRequestListResponse = userHomeRequestListResponseFromJson(jsonString);

import 'dart:convert';

List<UserHomeRequestListResponse> userHomeRequestListResponseFromJson(List str) => str.map((x) => UserHomeRequestListResponse.fromJson(x)).toList();

String userHomeRequestListResponseToJson(List<UserHomeRequestListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserHomeRequestListResponse {
  UserHomeRequestListResponse({
    this.isFavorite,
    this.problemType,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.updatedId,
    this.deleted,
    this.state,
    this.ownerId,
    this.lawyerId,
    this.problemTypeId,
    this.description,
    this.photos,
    this.privatePhone,
  });

  final bool? isFavorite;
  final ProblemType? problemType;
  final String? id;
  final int? createdAt;
  final dynamic updatedAt;
  final dynamic updatedId;
  final bool? deleted;
  final String? state;
  final String? ownerId;
  final String? lawyerId;
  final String? problemTypeId;
  final String? description;
  final List<String>? photos;
  final bool? privatePhone;

  factory UserHomeRequestListResponse.fromJson(Map<String, dynamic> json) => UserHomeRequestListResponse(
    isFavorite: json["is_favorite"],
    problemType: ProblemType.fromJson(json["problem_type"]),
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    updatedId: json["updated_id"],
    deleted: json["deleted"],
    state: json["state"],
    ownerId: json["owner_id"],
    lawyerId: json["lawyer_id"],
    problemTypeId: json["problem_type_id"],
    description: json["description"],
    photos: List<String>.from(json["photos"].map((x) => x)),
    privatePhone: json["private_phone"],
  );

  Map<String, dynamic> toJson() => {
    "is_favorite": isFavorite,
    "problem_type": problemType?.toJson(),
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "updated_id": updatedId,
    "deleted": deleted,
    "state": state,
    "owner_id": ownerId,
    "lawyer_id": lawyerId,
    "problem_type_id": problemTypeId,
    "description": description,
    "photos": List<dynamic>.from(photos!.map((x) => x)),
    "private_phone": privatePhone,
  };
}

class ProblemType {
  ProblemType({
    this.usEn,
    this.ruRu,
    this.uzLat,
    this.uzUz,
  });

  final String? usEn;
  final String? ruRu;
  final String? uzLat;
  final String? uzUz;

  factory ProblemType.fromJson(Map<String, dynamic> json) => ProblemType(
    usEn: json["us_en"],
    ruRu: json["ru_ru"],
    uzLat: json["uz_lat"],
    uzUz: json["uz_uz"],
  );

  Map<String, dynamic> toJson() => {
    "us_en": usEn,
    "ru_ru": ruRu,
    "uz_lat": uzLat,
    "uz_uz": uzUz,
  };
}
