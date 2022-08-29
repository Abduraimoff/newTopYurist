// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userType: userTypeFromString(json['user_type'] as String?),
      fullName: json['full_name'] as String?,
      finishedApplicatoinCount: json['finished_applicatoin_count'] as int?,
      selectedAmount: json['selected_amount'] as int?,
      offerAmount: json['offer_amount'] as int?,
      username: json['username'] as String?,
      lawyerState: lawyerIsVerified(json['lawyer_state'] as String?),
      profilePhoto: json['profile_photo'] as String?,
      callCount: json['call_count'] as int?,
      sentMessageCount: json['sent_message_count'] as int?,
      receivedMessageCount: json['received_message_count'] as int?,
      customerFavoriteCount: json['customer_favorite_count'] as int?,
      problemTypes: (json['problem_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      regionId: json['region_id'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_type': _$UserTypeEnumMap[instance.userType],
      'full_name': instance.fullName,
      'finished_applicatoin_count': instance.finishedApplicatoinCount,
      'selected_amount': instance.selectedAmount,
      'offer_amount': instance.offerAmount,
      'username': instance.username,
      'lawyer_state': instance.lawyerState,
      'profile_photo': instance.profilePhoto,
      'call_count': instance.callCount,
      'sent_message_count': instance.sentMessageCount,
      'received_message_count': instance.receivedMessageCount,
      'customer_favorite_count': instance.customerFavoriteCount,
      'problem_types': instance.problemTypes,
      'region_id': instance.regionId,
    };

const _$UserTypeEnumMap = {
  UserType.lawyer: 'lawyer',
  UserType.notLawyer: 'notLawyer',
};
