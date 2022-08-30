part of 'problem_type_list_bloc.dart';

@immutable
abstract class ProblemTypeListState extends Equatable{}

class ProblemTypeListInitial extends ProblemTypeListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ProblemTypeListLoadedStat extends ProblemTypeListState{
  final LawyerSelectServiceDetailResponse? response;

  ProblemTypeListLoadedStat(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}

class ProblemTypeListErrorState extends ProblemTypeListState{
  final String? error;

  ProblemTypeListErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}