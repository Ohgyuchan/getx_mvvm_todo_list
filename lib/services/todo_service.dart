import '../models/models.dart';

class TodoService {
  List<TodoModel> todos = [];

  Future<List<TodoModel>> fetchTodos() async {
    // 데이터를 가져오는 API 호출 구현
    return todos;
  }

  Future<void> addTodo(TodoModel todo) async {
    // 새로운 todo를 추가하는 API 호출 구현
    todos.add(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    // todo를 업데이트하는 API 호출 구현
    final index = todos.indexWhere((t) => t.id == todo.id);
    todos[index] = todo;
  }

  Future<void> deleteTodo(String id) async {
    // todo를 삭제하는 API 호출 구현
    todos.removeWhere((t) => t.id == id);
  }
}
