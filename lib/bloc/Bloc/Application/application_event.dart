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