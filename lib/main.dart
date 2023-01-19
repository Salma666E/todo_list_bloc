import 'package:flutter/material.dart';
import 'package:todo_list_bloc/todo_them.dart';
import 'package:todo_list_bloc/views/app_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterTodosTheme.light,
      darkTheme: FlutterTodosTheme.dark,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      home: const AppView(),
    );
  }
}
