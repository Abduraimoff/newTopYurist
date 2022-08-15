// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    this.data,
    this.credentials,
    this.state,
    this.id,
    this.userExits,
    this.statusCode,
    this.error
  });

  Data? data;
  Credentials? credentials;
  String? state;
  String? id;
  bool? userExits;
  int? statusCode;
  String? error;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    credentials: json["credentials"] == null ? null : Credentials.fromJson(json["credentials"]),
    state: json["state"],
    id: json["id"],
    userExits: json["user_exits"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "credentials": credentials?.toJson(),
    "state": state,
    "id": id,
    "user_exits": userExits,
  };
}

class Credentials {
  Credentials({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.refreshExpiresIn,
    this.notBeforePolicy,
    this.sessionState,
    this.scope,
  });

  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;
  int? refreshExpiresIn;
  int? notBeforePolicy;
  String? sessionState;
  String? scope;

  factory Credentials.fromJson(Map<String, dynamic> json) => Credentials(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    refreshToken: json["refresh_token"],
    refreshExpiresIn: json["refresh_expires_in"],
    notBeforePolicy: json["not-before-policy"],
    sessionState: json["session_state"],
    scope: json["scope"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "refresh_token": refreshToken,
    "refresh_expires_in": refreshExpiresIn,
    "not-before-policy": notBeforePolicy,
    "session_state": sessionState,
    "scope": scope,
  };
}

class Data {
  Data({
    this.problemTypes,
    this.userType,
    this.fullName,
    this.updatedAt,
    this.profilePhoto,
    this.regionId,
    this.createdAt,
    this.details,
    this.id,
    this.state,
    this.username,
  });

  String? problemTypes;
  String? userType;
  String? fullName;
  int? updatedAt;
  String? profilePhoto;
  int? regionId;
  int? createdAt;
  Details? details;
  String? id;
  String? state;
  String? username;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    problemTypes: json["problem_types"],
    userType: json["user_type"],
    fullName: json["full_name"],
    updatedAt: json["updated_at"],
    profilePhoto: json["profile_photo"],
    regionId: json["region_id"],
    createdAt: json["created_at"],
    details: Details.fromJson(json["details"]),
    id: json["id"],
    state: json["state"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "problem_types": problemTypes,
    "user_type": userType,
    "full_name": fullName,
    "updated_at": updatedAt,
    "profile_photo": profilePhoto,
    "region_id": regionId,
    "created_at": createdAt,
    "details": details?.toJson(),
    "id": id,
    "state": state,
    "username": username,
  };
}

class Details {
  Details({
    this.locale,
  });

  String? locale;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    locale: json["locale"],
  );

  Map<String, dynamic> toJson() => {
    "locale": locale,
  };
}
