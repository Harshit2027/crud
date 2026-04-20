import 'package:crud/features/data/models/todo_model.dart';
import 'package:crud/features/presentation/bloc/home/home_bloc.dart';
import 'package:crud/features/presentation/pages/add_edit_todo_page.dart';
import 'package:crud/features/presentation/widgets/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home-page';

  static Widget builder(BuildContext context) {
    return BlocProvider(create: (context) => HomeBloc(HomeState()), child: HomePage());
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc get bloc => BlocProvider.of<HomeBloc>(context);

  @override
  void initState() {
    context.read<HomeBloc>().add(LoadTodosEvent());
    super.initState();
  }

  Future<void> _openAddEditTodo({TodoModel? todo}) async {
    TodoModel? todoValue = await Navigator.pushNamed(context, AddEditTodoPage.routeName, arguments: todo);
    if (todoValue == null) return;
    if (todo == null) {
      bloc.add(AddTodoEvent(todoValue));
    } else {
      bloc.add(UpdateTodoEvent(todoValue));
    }
  }

  void _showDeleteTodoDialog(BuildContext context, TodoModel todo) {
    final parentContext = context;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Delete Todo'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [Text('Are you sure you want to delete this todo?')]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                parentContext.read<HomeBloc>().add(DeleteTodoEvent(todo));
                Navigator.pop(dialogContext);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        centerTitle: true,
        actions: [IconButton(onPressed: () => _openAddEditTodo(), icon: Icon(Icons.add))],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: Text('No Data Found'));
          }
          return ListView.separated(
            itemBuilder: (context, index) => TodoCard(
              data: state.todos[index],
              onEdit: () => _openAddEditTodo(todo: state.todos[index]),
              onDelete: () => _showDeleteTodoDialog(context, state.todos[index]),
            ),
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemCount: state.todos.length,
          );
        },
      ),
    );
  }
}
