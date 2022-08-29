// To parse this JSON data, do
//
//     final userFavoriteResponse = userFavoriteResponseFromJson(jsonString);

import 'dart:convert';

UserFavoriteResponse userFavoriteResponseFromJson(String str) => UserFavoriteResponse.fromJson(json.decode(str));

String userFavoriteResponseToJson(UserFavoriteResponse data) => json.encode(data.toJson());

class UserFavoriteResponse {
  UserFavoriteResponse({
    this.total,
    this.data,
  });

  final int? total;
  final List<UserFavoriteDatum>? data;

  factory UserFavoriteResponse.fromJson(Map<String, dynamic> json) => UserFavoriteResponse(
    total: json["total"],
    data: List<UserFavoriteDatum>.from(json["data"].map((x) => UserFavoriteDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UserFavoriteDatum {
  UserFavoriteDatum({
    this.id,
    this.profilePhoto,
    this.fullName,
    this.createdAt,
    this.lawyerState,
    this.reviewCount,
    this.workExperience,
  });

  final String? id;
  final String? profilePhoto;
  final String? fullName;
  final int? createdAt;
  final String? lawyerState;
  final int? reviewCount;
  final int? workExperience;

  factory UserFavoriteDatum.fromJson(Map<String, dynamic> json) => UserFavoriteDatum(
    id: json["id"],
    profilePhoto: json["profile_photo"],
    fullName: json["full_name"],
    createdAt: json["created_at"],
    lawyerState: json["lawyer_state"],
    reviewCount: json["review_count"],
    workExperience: json["work_experience"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_photo": profilePhoto,
    "full_name": fullName,
    "created_at": createdAt,
    "lawyer_state": lawyerState,
    "review_count": reviewCount,
    "work_experience": workExperience,
  };
}
