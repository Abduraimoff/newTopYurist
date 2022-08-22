import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:top_yurist/data/parser/parser.dart';

part 'user.g.dart';

enum UserType { lawyer, notLawyer }

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class User extends Equatable {
  @JsonKey(fromJson: userTypeFromString)
  final UserType? userType;
  final String? fullName;
  final int? acceptedCount;
  final int? selectedCount;
  final int? applicationCount;
  final String? username;
  @JsonKey(fromJson: lawyerIsVerified)
  final bool? lawyerState;
  final String? profilePhoto;
  final int? amountCalls;
  final int? amountSentMessages;
  final int? amountIncomingMessages;
  final int? amountFavorites;
  const User({
    this.userType,
    this.fullName,
    this.acceptedCount,
    this.selectedCount,
    this.applicationCount,
    this.username,
    this.lawyerState,
    this.profilePhoto,
    this.amountCalls,
    this.amountSentMessages,
    this.amountIncomingMessages,
    this.amountFavorites,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        applicationCount,
        userType,
        fullName,
        selectedCount,
        acceptedCount,
        username,
        lawyerState,
        profilePhoto
      ];

  User copyWith({
    UserType? userType,
    String? fullName,
    int? acceptedCount,
    int? selectedCount,
    int? applicationCount,
    String? username,
    bool? lawyerState,
    String? profilePhoto,
    int? amountCalls,
    int? amountSentMessages,
    int? amountIncomingMessages,
    int? amountFavorites,
  }) {
    return User(
      userType: userType ?? this.userType,
      fullName: fullName ?? this.fullName,
      acceptedCount: acceptedCount ?? this.acceptedCount,
      selectedCount: selectedCount ?? this.selectedCount,
      applicationCount: applicationCount ?? this.applicationCount,
      username: username ?? this.username,
      lawyerState: lawyerState ?? this.lawyerState,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      amountCalls: amountCalls ?? this.amountCalls,
      amountSentMessages: amountSentMessages ?? this.amountSentMessages,
      amountIncomingMessages:
          amountIncomingMessages ?? this.amountIncomingMessages,
      amountFavorites: amountFavorites ?? this.amountFavorites,
    );
  }
}
