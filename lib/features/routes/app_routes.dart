import 'package:crud/features/data/models/todo_model.dart';
import 'package:crud/features/presentation/bloc/add_edit/add_edit_bloc.dart';
import 'package:crud/features/presentation/bloc/home/home_bloc.dart';
import 'package:crud/features/presentation/pages/add_edit_todo_page.dart';
import 'package:crud/features/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouteGenerator {
  AppRouteGenerator();

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(create: (_) => HomeBloc(HomeState()), child: HomePage()),
        );

      case AddEditTodoPage.routeName:
        final todo = settings.arguments as TodoModel?;

        return MaterialPageRoute<TodoModel?>(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => AddEditBloc(AddEditState(todoModel: todo)),
            child: AddEditTodoPage(),
          ),
        );
      default:
        return null;
    }
  }
}
