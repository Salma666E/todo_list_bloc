import '../../todos_api/src/todo_api.dart';
import '../../todos_api/src/todo_mdl.dart';

class TodosRepository {
  TodosRepository({required TodosApi todosApi}) : _todosApi = todosApi;

  final TodosApi _todosApi;

  Stream<List<TodoMdl>> getTodo() => _todosApi.getTodo();
  Future<void> setTodo(TodoMdl todoMdl) => _todosApi.setTodo(todoMdl);
  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);
  Future<void> clearCompleted() => _todosApi.clearCompleted();
  Future<void> completedAll({required bool isCompleted}) =>
      _todosApi.completedAll(isCompleted: isCompleted);
}
