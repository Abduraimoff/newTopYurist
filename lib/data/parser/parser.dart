import 'package:top_yurist/data/Models/user/user.dart';

UserType? userTypeFromString(String? value) {
  if (value == null || value.isEmpty) return null;
  bool isLawyer = value == 'lawyer';
  return isLawyer ? UserType.lawyer : UserType.notLawyer;
}

bool? lawyerIsVerified(String? value) {
  if (value == null || value.isEmpty) return null;
  bool isVerified = value != 'UNVERIFIED';
  return isVerified;
}

bool? isProblemAccepted(String? value) {
  if (value == null || value.isEmpty) return null;
  bool isAccepted = value == 'ACCEPTED';
  return isAccepted;
}

DateTime? dateTimeParcer(int? value) {
  if (value == null) return null;
  final dateTime = DateTime.fromMillisecondsSinceEpoch(value);
  return dateTime;
}
