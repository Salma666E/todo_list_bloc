// will export a generic interface for interacting/managing todos.
import 'todo_mdl.dart';

abstract class TodosApi {
  const TodosApi();
  Stream<List<TodoMdl>> getTodo();
  Future<void> setTodo(TodoMdl todoMdl);
  Future<void> deleteTodo(String id);
  Future<void> clearCompleted();
  Future<void> completedAll({required bool isCompleted});
}

/// Error thrown when a [Todo] with a given id is not found.
class TodoNotFoundException implements Exception {}
