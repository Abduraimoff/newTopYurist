part of 'regions_bloc.dart';

@immutable
abstract class RegionsState  extends Equatable{}

class RegionsInitial extends RegionsState {
  @override
  List<Object?> get props => [];
}

class RegionsErrorState extends RegionsState{
  final Object error;

  RegionsErrorState(this.error);
  @override
  List<Object?> get props => [error];

}
class RegionsLoadedSuccessState extends RegionsState{
final List<RegionsResponse> response;

  RegionsLoadedSuccessState(this.response);
  @override
  List<Object?> get props => [response];

}
