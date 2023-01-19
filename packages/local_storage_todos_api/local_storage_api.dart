//This package implements the todos_api using the shared_preferences package.
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../todos_api/src/todo_api.dart';
import '../todos_api/src/todo_mdl.dart';

class LocalStorageTodosApi extends TodosApi {
  LocalStorageTodosApi({required SharedPreferences plugin}) : _plugin = plugin {
    _init();
  }
  //The first element of this stream.
  //How to update flutter widget using RxDart BehaviorSubject?
  final _todoStreamController = BehaviorSubject<List<TodoMdl>>.seeded(const []);

  final SharedPreferences _plugin;

  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kTodosCollectionKey = '__todos_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final todosJson = _getValue(kTodosCollectionKey);
    if (todosJson != null) {
      final todos = List<Map<dynamic, dynamic>>.from(
        json.decode(todosJson) as List,
      )
          .map(
              (jsonMap) => TodoMdl.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _todoStreamController.add(todos);
    } else {
      _todoStreamController.add(const []);
    }
  }

//end visibleForTesting

  @override
  Stream<List<TodoMdl>> getTodo() => _todoStreamController.asBroadcastStream();

  @override
  Future<void> setTodo(TodoMdl todoMdl) {
    final todo = [..._todoStreamController.value];
    final todoIndex = todo.indexWhere((t) => t.id == todoMdl.id);
    if (todoIndex >= 0) {
      todo[todoIndex] = todoMdl;
    } else {
      todo.add(todoMdl);
    }
    _todoStreamController.add(todo);
    return _setValue(kTodosCollectionKey, json.encode(todo));
  }

  @override
  Future<void> deleteTodo(String id) {
    final todo = [..._todoStreamController.value];
    final todoIndex = todo.indexWhere((t) => t.id == id);
    if (todoIndex == -1)
      throw TodoNotFoundException;
    else {
      todo.removeAt(todoIndex);
      _todoStreamController.add(todo);
      return _setValue(kTodosCollectionKey, json.encode(todo));
    }
  }

  @override
  Future<void> clearCompleted() async {
    final todo = [..._todoStreamController.value];
    // final completedTodosAmount =
    //     todo.where((element) => element.isCompleted == true).length;
    todo.removeWhere((t) => t.isCompleted == true);
    _todoStreamController.add(todo);
    await _setValue(kTodosCollectionKey, json.encode(todo));
    // return completedTodosAmount;
  }

  @override
  Future<void> completedAll({required bool isCompleted}) async {
    final todoList = [..._todoStreamController.value];
    final newTodos = [
      for (final todo in todoList) todo.copyWith(isCompleted: isCompleted)
    ];
    _todoStreamController.add(newTodos);
    _setValue(kTodosCollectionKey, json.encode(newTodos));
  }
}
