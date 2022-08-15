part of 'problem_type_bloc.dart';

@immutable
abstract class ProblemTypeState extends Equatable{}

class ProblemTypeInitial extends ProblemTypeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProblemLoadedSuccess extends ProblemTypeState{
  final List<RegionsResponse> response;

  ProblemLoadedSuccess(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}
class ProblemErrorState extends ProblemTypeState{
  final Object error;

  ProblemErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
