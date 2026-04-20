part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<TodoModel> todos;
  final bool isLoading;

  const HomeState({this.todos = const <TodoModel>[], this.isLoading = false});

  @override
  List<Object?> get props => [todos, isLoading];

  HomeState copyWith({
    List<TodoModel>? todos,
    bool? isLoading,
  }) {
    return HomeState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
