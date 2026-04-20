import 'package:crud/core/theme/theme_cubit.dart';
import 'package:crud/features/data/models/todo_model.dart';
import 'package:crud/features/presentation/bloc/add_edit/add_edit_bloc.dart';
import 'package:crud/features/presentation/bloc/home/home_bloc.dart';
import 'package:crud/features/presentation/pages/add_edit_todo_page.dart';
import 'package:crud/features/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late final AppRouteGenerator appRoutes = AppRouteGenerator();

    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ThemeCubit(ThemeState(themeMode: .light)))],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRoutes.call,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        // routes: routes,
        initialRoute: HomePage.routeName,
        // home: HomePage(),
      ),
    );
  }
}

class AppRouteGenerator {
  AppRouteGenerator();

  Route? call(RouteSettings settings) {
    var routeInfo = _routes[settings.name];
    if (routeInfo == null) return null;
    return routeInfo(settings);
  }

  final _routes = <String, Route Function(RouteSettings)>{
    HomePage.routeName: (settings) => MaterialPageRoute(settings: settings, builder: HomePage.builder),
    AddEditTodoPage.routeName: (settings) {
      return MaterialPageRoute<TodoModel?>(settings: settings, builder: AddEditTodoPage.builder);
    },
  };
}
