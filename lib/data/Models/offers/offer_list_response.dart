// To parse this JSON data, do
//
//     final offerListResponse = offerListResponseFromJson(jsonString);

import 'dart:convert';

OfferListResponse offerListResponseFromJson(String str) => OfferListResponse.fromJson(json.decode(str));

String offerListResponseToJson(OfferListResponse data) => json.encode(data.toJson());

class OfferListResponse {
  OfferListResponse({
    this.total,
    this.data,
  });

  final int? total;
  final List<Datum>? data;

  factory OfferListResponse.fromJson(Map<String, dynamic> json) => OfferListResponse(
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
    this.id,
    this.createdAt,
    this.state,
    this.description,
    this.offerPrice,
    this.applicationId,
    this.lawyerId,
    this.chatId,
    this.lawyerFullName,
    this.lawyerProfilePhoto,
    this.lawyerPhoneNumber,
    this.verificationState,
    this.applicationState,
    this.isSelected,
    this.isFavorite,
    this.doneApplicationCount,
    this.reviewCount,
    this.workExperience,
    this.inSystemYears,
  });

  final String? id;
  final int? createdAt;
  final String? state;
  final String? description;
  final String? offerPrice;
  final String? applicationId;
  final String? lawyerId;
  final String? chatId;
  final String? lawyerFullName;
  final String? lawyerProfilePhoto;
  final String? lawyerPhoneNumber;
  final String? verificationState;
  final String? applicationState;
  final bool? isSelected;
  final bool? isFavorite;
  final int? doneApplicationCount;
  final int? reviewCount;
  final int? workExperience;
  final int? inSystemYears;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    createdAt: json["created_at"],
    state: json["state"],
    description: json["description"],
    offerPrice: json["offer_price"],
    applicationId: json["application_id"],
    lawyerId: json["lawyer_id"],
    chatId: json["chat_id"],
    lawyerFullName: json["lawyer_full_name"],
    lawyerProfilePhoto: json["lawyer_profile_photo"],
    lawyerPhoneNumber: json["lawyer_phone_number"],
    verificationState: json["verification_state"],
    applicationState: json["application_state"],
    isSelected: json["is_selected"],
    isFavorite: json["is_favorite"],
    doneApplicationCount: json["done_application_count"],
    reviewCount: json["review_count"],
    workExperience: json["work_experience"],
    inSystemYears: json["in_system_years"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "state": state,
    "description": description,
    "offer_price": offerPrice,
    "application_id": applicationId,
    "lawyer_id": lawyerId,
    "chat_id": chatId,
    "lawyer_full_name": lawyerFullName,
    "lawyer_profile_photo": lawyerProfilePhoto,
    "lawyer_phone_number": lawyerPhoneNumber,
    "verification_state": verificationState,
    "application_state": applicationState,
    "is_selected": isSelected,
    "is_favorite": isFavorite,
    "done_application_count": doneApplicationCount,
    "review_count": reviewCount,
    "work_experience": workExperience,
    "in_system_years": inSystemYears,
  };
}
