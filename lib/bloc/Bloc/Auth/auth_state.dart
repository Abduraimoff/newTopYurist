part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable{}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState{
  final String? error;

  AuthErrorState({this.error});
  @override
  List<Object?> get props => [error];
}

class PhoneNumberVerifiedSuccessState  extends AuthState{
  final PhoneVerifiedResponse response;
  PhoneNumberVerifiedSuccessState(this.response);
  @override
  List<Object?> get props => [response];
}

class OtpCodeSuccessState extends AuthState{
  final ProfileResponse? response;

  OtpCodeSuccessState({this.response});
  @override
  List<Object?> get props => [response];
}

class UploadImageSuccessState extends AuthState{
  final ImageResponse? response;

  UploadImageSuccessState({this.response});
  @override
  List<Object?> get props => [response];

}
class RegisterUserSuccessState extends AuthState{
  final ProfileResponse response;

  RegisterUserSuccessState(this.response);
  @override
  List<Object?> get props => [response];

}