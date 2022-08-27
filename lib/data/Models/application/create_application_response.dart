

class CreateApplicationResponse {
  CreateApplicationResponse({
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

  final String? id;
  final int? createdAt;
  final dynamic updatedAt;
  final dynamic updatedId;
  final bool? deleted;
  final String? state;
  final String? ownerId;
  final dynamic lawyerId;
  final String? problemTypeId;
  final String? description;
  final List<String>? photos;
  final bool? privatePhone;

  factory CreateApplicationResponse.fromJson(Map<String, dynamic> json) => CreateApplicationResponse(
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
