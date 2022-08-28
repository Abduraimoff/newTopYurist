part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable{}

class VerifyPhoneNumber extends AuthEvent{
  final String? userType;
  final String? phoneNumber;
  final BuildContext context;
  VerifyPhoneNumber({required this.userType, required this.phoneNumber, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [userType, phoneNumber, context];
}

class OtpCodeSendEvent extends AuthEvent{

  final BuildContext? context;
  OtpCodeSendEvent({ this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [context];

}

class UploadImageEvent extends AuthEvent{
  final File file;
  final String category;
  UploadImageEvent(this.file, this.category);
  @override
  List<Object?> get props => [file];
}

class RegisterUserEvent extends AuthEvent{
  final NewUser user;

  RegisterUserEvent(this.user);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
