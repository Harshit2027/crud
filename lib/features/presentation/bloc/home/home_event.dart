part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadTodosEvent extends HomeEvent {}

class AddTodoEvent extends HomeEvent {
  final TodoModel todo;
  AddTodoEvent(this.todo);
}

class DeleteTodoEvent extends HomeEvent {
  final TodoModel todo;
  DeleteTodoEvent(this.todo);
}

class UpdateTodoEvent extends HomeEvent {
  final TodoModel todo;
  UpdateTodoEvent(this.todo);
}
