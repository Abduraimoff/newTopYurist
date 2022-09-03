// To parse this JSON data, do
//
//     final lawyerSelectServiceDetailResponse = lawyerSelectServiceDetailResponseFromJson(jsonString);

import 'dart:convert';

import '../user/user_home_request_list.dart';

LawyerSelectServiceDetailResponse lawyerSelectServiceDetailResponseFromJson(String str) => LawyerSelectServiceDetailResponse.fromJson(json.decode(str));

String lawyerSelectServiceDetailResponseToJson(LawyerSelectServiceDetailResponse data) => json.encode(data.toJson());

class LawyerSelectServiceDetailResponse {
  LawyerSelectServiceDetailResponse({
    this.total,
    this.data,
  });

  final int? total;
  final List<Datum>? data;

  factory LawyerSelectServiceDetailResponse.fromJson(Map<String, dynamic> json) => LawyerSelectServiceDetailResponse(
    total: json["total"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.isFavorite,
    this.problemType,
    this.ownerProfilePhoto,
    this.ownerFullName,
    this.regionTitle,
    this.regionId,
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
  final String? ownerProfilePhoto;
  final String? ownerFullName;
  final ProblemType? regionTitle;
  final int? regionId;
  final String? id;
  final int? createdAt;
  final int? updatedAt;
  final dynamic updatedId;
  final bool? deleted;
  final String? state;
  final String? ownerId;
  final String? lawyerId;
  final String? problemTypeId;
  final String? description;
  final List<String>? photos;
  final bool? privatePhone;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    isFavorite: json["is_favorite"],
    problemType: ProblemType.fromJson(json["problem_type"]),
    ownerProfilePhoto: json["owner_profile_photo"],
    ownerFullName: json["owner_full_name"],
    regionTitle: ProblemType.fromJson(json["region_title"]),
    regionId: json["region_id"],
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
    "owner_profile_photo": ownerProfilePhoto,
    "owner_full_name": ownerFullName,
    "region_title": regionTitle?.toJson(),
    "region_id": regionId,
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


