import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:top_yurist/data/parser/parser.dart';

part 'review.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Review extends Equatable {
  final String id;
  final String? ownerFullName;
  final String? ownerProfilePhoto;
  final String? lawerFullName;
  final String? lawerProfilePhoto;
  @JsonKey(fromJson: isProblemAccepted, name: 'state')
  final bool? isAccepted;
  @JsonKey(fromJson: dateTimeParcer)
  final DateTime? createdAt;
  final String? stateReason;
  final String ownerId;
  final String lawyerId;
  const Review({
    required this.id,
    required this.ownerFullName,
    required this.ownerProfilePhoto,
    required this.lawerFullName,
    required this.lawerProfilePhoto,
    required this.isAccepted,
    required this.createdAt,
    required this.stateReason,
    required this.ownerId,
    required this.lawyerId,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  Review copyWith({
    String? id,
    String? ownerFullName,
    String? ownerProfilePhoto,
    String? lawerFullName,
    String? lawerProfilePhoto,
    bool? isAccepted,
    DateTime? createdAt,
    String? stateReason,
    String? ownerId,
    String? lawyerId,
  }) {
    return Review(
      id: id ?? this.id,
      ownerFullName: ownerFullName ?? this.ownerFullName,
      ownerProfilePhoto: ownerProfilePhoto ?? this.ownerProfilePhoto,
      lawerFullName: lawerFullName ?? this.lawerFullName,
      lawerProfilePhoto: lawerProfilePhoto ?? this.lawerProfilePhoto,
      isAccepted: isAccepted ?? this.isAccepted,
      createdAt: createdAt ?? this.createdAt,
      stateReason: stateReason ?? this.stateReason,
      ownerId: ownerId ?? this.ownerId,
      lawyerId: lawyerId ?? this.lawyerId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        ownerFullName,
        ownerProfilePhoto,
        lawerFullName,
        lawerProfilePhoto,
        isAccepted,
        createdAt,
        stateReason,
        ownerId,
        lawyerId,
      ];
}
