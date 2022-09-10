// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as String,
      ownerFullName: json['owner_full_name'] as String?,
      ownerProfilePhoto: json['owner_profile_photo'] as String?,
      lawerFullName: json['lawer_full_name'] as String?,
      lawerProfilePhoto: json['lawer_profile_photo'] as String?,
      isAccepted: isProblemAccepted(json['state'] as String?),
      createdAt: dateTimeParcer(json['created_at'] as int?),
      stateReason: json['state_reason'] as String?,
      ownerId: json['owner_id'] as String,
      lawyerId: json['lawyer_id'] as String,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'owner_full_name': instance.ownerFullName,
      'owner_profile_photo': instance.ownerProfilePhoto,
      'lawer_full_name': instance.lawerFullName,
      'lawer_profile_photo': instance.lawerProfilePhoto,
      'state': instance.isAccepted,
      'created_at': instance.createdAt?.toIso8601String(),
      'state_reason': instance.stateReason,
      'owner_id': instance.ownerId,
      'lawyer_id': instance.lawyerId,
    };
