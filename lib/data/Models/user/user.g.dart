// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userType: userTypeFromString(json['user_type'] as String?),
      fullName: json['full_name'] as String?,
      acceptedCount: json['accepted_count'] as int?,
      selectedCount: json['selected_count'] as int?,
      applicationCount: json['application_count'] as int?,
      username: json['username'] as String?,
      lawyerState: lawyerIsVerified(json['lawyer_state'] as String?),
      profilePhoto: json['profile_photo'] as String?,
      amountCalls: json['amount_calls'] as int?,
      amountSentMessages: json['amount_sent_messages'] as int?,
      amountIncomingMessages: json['amount_incoming_messages'] as int?,
      amountFavorites: json['amount_favorites'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_type': _$UserTypeEnumMap[instance.userType],
      'full_name': instance.fullName,
      'accepted_count': instance.acceptedCount,
      'selected_count': instance.selectedCount,
      'application_count': instance.applicationCount,
      'username': instance.username,
      'lawyer_state': instance.lawyerState,
      'profile_photo': instance.profilePhoto,
      'amount_calls': instance.amountCalls,
      'amount_sent_messages': instance.amountSentMessages,
      'amount_incoming_messages': instance.amountIncomingMessages,
      'amount_favorites': instance.amountFavorites,
    };

const _$UserTypeEnumMap = {
  UserType.lawyer: 'lawyer',
  UserType.notLawyer: 'notLawyer',
};
