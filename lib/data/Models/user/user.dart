import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:top_yurist/data/parser/parser.dart';

part 'user.g.dart';

enum UserType {lawyer, notLawyer }

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class User extends Equatable {
  @JsonKey(fromJson: userTypeFromString)
  final UserType? userType;
  final String? fullName;
  final int? finishedApplicatoinCount;
  final int? selectedAmount;
  final int? offerAmount;
  final String? username;
  @JsonKey(fromJson: lawyerIsVerified)
  final bool? lawyerState;
  final String? profilePhoto;
  final int? callCount;
  final int? sentMessageCount;
  final int? receivedMessageCount;
  final int? customerFavoriteCount;
  final List<String>? problemTypes;
  final int? regionId;
  final String? id;
  const User({
    this.userType,
    this.fullName,
    this.finishedApplicatoinCount,
    this.selectedAmount,
    this.offerAmount,
    this.username,
    this.lawyerState,
    this.profilePhoto,
    this.callCount,
    this.sentMessageCount,
    this.receivedMessageCount,
    this.customerFavoriteCount,
    this.problemTypes,
    this.regionId,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        userType,
        fullName,
        finishedApplicatoinCount,
        selectedAmount,
        offerAmount,
        username,
        lawyerState,
        profilePhoto,
        callCount,
        sentMessageCount,
        receivedMessageCount,
        customerFavoriteCount,
        problemTypes,
        regionId,
      ];

  User copyWith({
    UserType? userType,
    String? fullName,
    int? finishedApplicatoinCount,
    int? selectedAmount,
    int? offerAmount,
    String? username,
    bool? lawyerState,
    String? profilePhoto,
    int? callCount,
    int? sentMessageCount,
    int? receivedMessageCount,
    int? customerFavoriteCount,
    List<String>? problemTypes,
    int? regionId,
    String? id,
  }) {
    return User(
      userType: userType ?? this.userType,
      fullName: fullName ?? this.fullName,
      finishedApplicatoinCount:
          finishedApplicatoinCount ?? this.finishedApplicatoinCount,
      selectedAmount: selectedAmount ?? this.selectedAmount,
      offerAmount: offerAmount ?? this.offerAmount,
      username: username ?? this.username,
      lawyerState: lawyerState ?? this.lawyerState,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      callCount: callCount ?? this.callCount,
      sentMessageCount: sentMessageCount ?? this.sentMessageCount,
      receivedMessageCount: receivedMessageCount ?? this.receivedMessageCount,
      customerFavoriteCount:
          customerFavoriteCount ?? this.customerFavoriteCount,
      problemTypes: problemTypes ?? this.problemTypes,
      regionId: regionId ?? this.regionId,
      id: id ?? this.id,
    );
  }
}
