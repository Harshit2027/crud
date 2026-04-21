 import 'package:crud/core/theme/theme_cubit.dart';
import 'package:crud/features/presentation/pages/home_page.dart';
import 'package:crud/features/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 class MyApp extends StatelessWidget {
   const MyApp({super.key});

   // This widget is the root of your application.
   @override
   Widget build(BuildContext context) {
     return MultiBlocProvider(
       providers: [BlocProvider(create: (context) => ThemeCubit(ThemeState(themeMode: .light)))],
       child: MaterialApp(
         title: 'Flutter Demo',
         debugShowCheckedModeBanner: false,
         onGenerateRoute: AppRouteGenerator.onGenerateRoute,
         theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
         initialRoute: HomePage.routeName,
         // home: HomePage(),
       ),
     );
   }
 }