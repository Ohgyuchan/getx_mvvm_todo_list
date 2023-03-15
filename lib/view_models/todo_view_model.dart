import 'package:get/get.dart';

import '../models/models.dart';
import '../services/todo_service.dart';

class TodoViewModel extends GetxController {
  final _todos = <TodoModel>[].obs;
  final _todoService = TodoService();

  List<TodoModel> get todos => _todos.toList();

  fetchApi() async {
    final todosFromApi = await _todoService.fetchTodos();
    _todos.value = todosFromApi;
    _todos.refresh();
  }

  Future<void> addTodo(TodoModel todo) async {
    await _todoService.addTodo(todo);
    await fetchApi();
  }

  Future<void> deleteTodo(String id) async {
    await _todoService.deleteTodo(id);
    await fetchApi();
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    await _todoService.updateTodo(updatedTodo);
    await fetchApi();
  }

  @override
  void onInit() {
    fetchApi();
    super.onInit();
  }
}
