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
