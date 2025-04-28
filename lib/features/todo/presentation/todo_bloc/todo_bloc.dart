import 'dart:async';

import 'package:delala/features/todo/data/model/todo.dart';
import 'package:delala/features/todo/domain/use_case/todo_use.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoUse _todoUse;
  TodoBloc(this._todoUse) : super(TodoInitial()) {
   on<GetTodoEvent>(_getTodoEventHandler);
   on<AddTodo>(_addTodoEvenHanler);
     
  }

  FutureOr<void> _getTodoEventHandler(GetTodoEvent event, Emitter<TodoState> emit,)  async {
    emit(TodoLoading());
    try{
      final todos = await _todoUse.fetchTodo();
      emit(TodoLoaded(todos: todos));
    }catch(e){
      // emit  a failure state here\
      emit(TodoFailure(errorMesage: 'Failed to get todos.'));
      throw Exception(e);
    }
  }

  FutureOr<void> _addTodoEvenHanler(AddTodo event, Emitter<TodoState> emit) async {
  }
}
