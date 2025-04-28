import 'dart:io';

import 'package:delala/features/todo/data/model/todo.dart';
import 'package:delala/features/todo/data/service/todo_service.dart';
import 'package:delala/features/todo/domain/repository/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  final TodoService _todoService;
  TodoRepoImpl(this._todoService);
  @override
  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    try {
      final response = await _todoService.fetchTodos();

      if (response.statusCode == HttpStatus.ok) {
   
        for (var todo in response.data) {
          todos.add(Todo.fromJson(todo));
        }
      }
      return todos;
    } catch (e) {
      throw Exception(e);
    }
  }
}
