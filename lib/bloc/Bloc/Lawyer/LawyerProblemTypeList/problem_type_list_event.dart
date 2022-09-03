part of 'problem_type_list_bloc.dart';

@immutable
abstract class ProblemTypeListEvent extends Equatable{}

class GetProblemListEvent extends ProblemTypeListEvent{
  final int? regionId;
  final String? problemTypeId;

  GetProblemListEvent({this.regionId, this.problemTypeId});
  @override
  // TODO: implement props
  List<Object?> get props => [regionId,problemTypeId ];

}

class UnFavoriteYuristEvent extends ProblemTypeListEvent{
  final String? id;

  UnFavoriteYuristEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}
class MakeFavoriteYuristEven extends ProblemTypeListEvent{
  final String? id;

  MakeFavoriteYuristEven(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}