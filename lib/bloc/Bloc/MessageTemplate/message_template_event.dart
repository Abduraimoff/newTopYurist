part of 'message_template_bloc.dart';

abstract class MessageTemplateEvent extends Equatable {
  const MessageTemplateEvent();
}
class CreateNewTemplateEvent extends MessageTemplateEvent{
  final String? description;

  const CreateNewTemplateEvent(this.description);
  @override
  // TODO: implement props
  List<Object?> get props => [description];
}

class GetMessageTemplateEvent extends MessageTemplateEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UpdateTemplateEvent extends MessageTemplateEvent{
  final String? id;
  final String? description;

  const UpdateTemplateEvent({this.id, this.description});
  @override
  // TODO: implement props
  List<Object?> get props => [id, description];

}

class DeleteTemplateEvent extends MessageTemplateEvent{
  final String? id;


  const DeleteTemplateEvent({this.id, });
  @override
  // TODO: implement props
  List<Object?> get props => [id,];

}