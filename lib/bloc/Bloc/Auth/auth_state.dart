part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable{}

class AuthInitial extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AuthErrorState extends AuthState{
  final Object? error;

  AuthErrorState({this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
class PhoneNumberVerifiedSuccessState  extends AuthState{
  final PhoneVerifiedResponse response;
  PhoneNumberVerifiedSuccessState(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class OtpCodeSuccessState extends AuthState{
  final ProfileResponse? response;

  OtpCodeSuccessState({this.response});
  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class UploadImageSuccessState extends AuthState{
  final ImageResponse? response;

  UploadImageSuccessState({this.response});
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}
class RegisterUserSuccessState extends AuthState{
  final ProfileResponse response;

  RegisterUserSuccessState(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}