import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/models.dart';
import 'view_models/todo_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TodoList with GetX & MVVM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatelessWidget {
  TodoListPage({Key? key}) : super(key: key);

  final _todoViewModel = Get.put(TodoViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList with GetX & MVVM'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _todoViewModel.todos.length,
          itemBuilder: (context, index) {
            final todo = _todoViewModel.todos[index];
            return ListTile(
              title: Text(todo.title),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async =>
                    await _todoViewModel.deleteTodo(todo.id!),
              ),
              onTap: () {
                Get.dialog(
                  _buildEditTodoDialog(todo),
                  barrierDismissible: false,
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.dialog(
            _buildAddTodoDialog(),
            barrierDismissible: false,
          );
        },
      ),
    );
  }

  Widget _buildAddTodoDialog() {
    final TextEditingController titleController = TextEditingController();

    return AlertDialog(
      title: const Text('Add Todo'),
      content: TextField(
        controller: titleController,
        decoration: const InputDecoration(
          hintText: 'Enter todo title',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final title = titleController.text.trim();
            if (title.isNotEmpty) {
              await _todoViewModel.addTodo(TodoModel(
                title: title,
                id: DateTime.now().millisecondsSinceEpoch.toString(),
              ));
            }
            Get.back();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  Widget _buildEditTodoDialog(TodoModel todo) {
    final TextEditingController titleController =
        TextEditingController(text: todo.title);

    return AlertDialog(
      title: const Text('Edit Todo'),
      content: TextField(
        controller: titleController,
        decoration: const InputDecoration(
          hintText: 'Enter todo title',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final title = titleController.text.trim();
            if (title.isNotEmpty) {
              _todoViewModel.updateTodo(TodoModel(
                title: title,
                isDone: todo.isDone,
                id: todo.id,
              ));
            }
            Get.back();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
