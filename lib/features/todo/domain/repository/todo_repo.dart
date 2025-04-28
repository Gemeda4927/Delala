
 import 'package:delala/features/todo/data/model/todo.dart';

abstract class TodoRepo {
    Future<List<Todo>> getTodos();
}