import 'package:delala/features/todo/data/model/todo.dart';
import 'package:delala/features/todo/domain/repository/todo_repo.dart';

class TodoUse {
  final TodoRepo _todoRepo;
  TodoUse(this._todoRepo);
  Future<List<Todo>> fetchTodo() async {
    return await _todoRepo.getTodos();
  }
}