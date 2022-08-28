part of 'problem_type_bloc.dart';

@immutable
abstract class ProblemTypeState extends Equatable{}

class ProblemTypeInitial extends ProblemTypeState {
  @override
  List<Object?> get props => [];
}

class ProblemLoadedSuccess extends ProblemTypeState{
  final List<RegionsResponse> response;

  ProblemLoadedSuccess(this.response);
  @override
  List<Object?> get props => [response];

}

class ProblemErrorState extends ProblemTypeState{
  final Object error;

  ProblemErrorState(this.error);
  @override
  List<Object?> get props => [];

}
