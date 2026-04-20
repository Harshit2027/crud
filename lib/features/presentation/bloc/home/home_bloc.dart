import 'package:crud/features/services/sql_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/features/data/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    on<LoadTodosEvent>(_onLoadData);
    on<AddTodoEvent>(_onAddData);
    on<DeleteTodoEvent>(_onDeleteData);
    on<UpdateTodoEvent>(_onUpdateData);
  }

  Future<void> _onLoadData(LoadTodosEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    final List<TodoModel> todos = await SqlService.helper.getTodos();

    emit(state.copyWith(todos: todos, isLoading: false));
  }

  Future<void> _onAddData(AddTodoEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    int result = await SqlService.helper.addTodo(event.todo);
    if (result == 0) {
      emit(state.copyWith(isLoading: false));
      return;
    }

    List<TodoModel> todos = List.from(state.todos)..add(event.todo);
    emit(state.copyWith(todos: todos, isLoading: false));
  }

  Future<void> _onDeleteData(DeleteTodoEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    if (event.todo.id == null) {
      emit(state.copyWith(isLoading: false));
      return;
    }
    int result = await SqlService.helper.deleteTodo(event.todo.id!);
    if (result != 1) {
      emit(state.copyWith(isLoading: false));
      return;
    }
    List<TodoModel> todos = List.from(state.todos);
    todos.removeWhere((element) => element.id == event.todo.id);
    emit(state.copyWith(todos: todos, isLoading: false));
  }

  Future<void> _onUpdateData(UpdateTodoEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    int result = await SqlService.helper.updateTodo(event.todo);
    if (result != 1) {
      emit(state.copyWith(isLoading: false));
      return;
    }
    List<TodoModel> todos = List.from(state.todos);
    final int index = todos.indexWhere((element) => element.id == event.todo.id);
    if (index != -1) {
      todos[index] = event.todo;
    }
    emit(state.copyWith(todos: todos, isLoading: false));
  }
}
