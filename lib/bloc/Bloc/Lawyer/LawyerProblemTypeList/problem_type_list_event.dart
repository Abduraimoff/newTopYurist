part of 'problem_type_list_bloc.dart';

@immutable
abstract class ProblemTypeListEvent extends Equatable{}

class GetProblemListEvent extends ProblemTypeListEvent{
  final String? regionId;
  final String? problemTypeId;

  GetProblemListEvent({this.regionId, this.problemTypeId});
  @override
  // TODO: implement props
  List<Object?> get props => [regionId,problemTypeId ];

}