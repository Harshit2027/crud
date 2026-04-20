part of 'add_edit_bloc.dart';

abstract class AddEditEvent {}

class AddEvent extends AddEditEvent {
  AddEvent();
}

class EditEvent extends AddEditEvent {
  final TodoModel? todoModel;
  EditEvent(this.todoModel);
}

class LoadTodoEvent extends AddEditEvent {
  final TodoModel? todoModel;
  LoadTodoEvent(this.todoModel);
}

class SubmitEvent extends AddEditEvent {

  final String title;
  final String description;

  SubmitEvent({required this.title, required this.description});
}


