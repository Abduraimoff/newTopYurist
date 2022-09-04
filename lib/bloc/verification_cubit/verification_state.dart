part of 'verification_cubit.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationLoadedState extends VerificationState {
  const VerificationLoadedState(this.verify);
  final Verify verify;

  @override
  List<Object> get props => [verify];
}
