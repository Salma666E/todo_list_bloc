import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_todos/bootstrap.dart';
import 'package:local_storage_todos_api/';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todosApi = LocalStorageTodosApi(
    plugin: await SharedPreferences.getInstance(),
  );

  // bootstrap(todosApi: todosApi);
}
