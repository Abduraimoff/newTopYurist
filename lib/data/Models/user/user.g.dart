// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userType: userTypeFromString(json['user_type'] as String?),
      fullName: json['full_name'] as String?,
      finishedApplicatoinCount: json['accepted_count'] as int?,
      selectedAmount: json['selected_count'] as int?,
      offerAmount: json['application_count'] as int?,
      username: json['username'] as String?,
      lawyerState: lawyerIsVerified(json['lawyer_state'] as String?),
      profilePhoto: json['profile_photo'] as String?,
      callCount: json['amount_calls'] as int?,
      sentMessageCount: json['amount_sent_messages'] as int?,
      receivedMessageCount: json['amount_incoming_messages'] as int?,
      customerFavoriteCount: json['amount_favorites'] as int?,
      problemTypes: (json['problem_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      regionId: json['region_id'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_type': _$UserTypeEnumMap[instance.userType],
      'full_name': instance.fullName,
      'accepted_count': instance.finishedApplicatoinCount,
      'selected_count': instance.selectedAmount,
      'application_count': instance.offerAmount,
      'username': instance.username,
      'lawyer_state': instance.lawyerState,
      'profile_photo': instance.profilePhoto,
      'amount_calls': instance.callCount,
      'amount_sent_messages': instance.sentMessageCount,
      'amount_incoming_messages': instance.receivedMessageCount,
      'amount_favorites': instance.customerFavoriteCount,
      'problem_types': instance.problemTypes,
      'region_id': instance.regionId,
    };

const _$UserTypeEnumMap = {
  UserType.lawyer: 'lawyer',
  UserType.notLawyer: 'notLawyer',
};
