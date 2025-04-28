part of 'todo_bloc.dart';


abstract class TodoEvent {}


class GetTodoEvent extends TodoEvent{}
class AddTodo extends TodoEvent{
  final Todo todo;
  AddTodo({required this.todo});
  }