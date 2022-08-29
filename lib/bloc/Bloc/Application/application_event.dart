part of 'application_bloc.dart';

@immutable
abstract class ApplicationEvent extends Equatable{}

class CreateApplicationEvent extends ApplicationEvent{
  final Map<String, dynamic> data;

  CreateApplicationEvent(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];

}
class UpdateApplicationEvent extends ApplicationEvent{
  final Map<String, dynamic> data;
  final String? id;

  UpdateApplicationEvent(this.data,  this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [data];

}

class PublishEvent extends ApplicationEvent{
  final String id;

  PublishEvent( this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}
class GetRequestsList extends ApplicationEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class FilterEvent extends ApplicationEvent{
  final String? state;

  FilterEvent(this.state);
  @override
  // TODO: implement props
  List<Object?> get props => [state];

}

class ApplicationDeleteEvent extends ApplicationEvent{
  final String? id;
  ApplicationDeleteEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ApplicationResume extends ApplicationEvent{
  final String id;

  ApplicationResume(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}

class ApplicationAddFavouriteEvent extends ApplicationEvent{
  final String? id;

  ApplicationAddFavouriteEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}