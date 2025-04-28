import 'package:delala/features/todo/presentation/todo_bloc/todo_bloc.dart';
import 'package:delala/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  void initState() {
    super.initState();
     todoBloc.add(GetTodoEvent());
    
  }
  final todoBloc = sl<TodoBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: BlocBuilder<TodoBloc, TodoState>(
        bloc: todoBloc,
        builder: (context, state) {
          print('=>   $state');
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
             if(state.todos.isEmpty){
              return Center(child: Text('Sorry there is not todos to show.'),);
             }
            return Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                  itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("${index +1}"),
                    title: Text(state.todos[index].title),
                  
                  );
                },
              ),
            );
          } else if (state is TodoFailure) {
            return Center(child: Text(state.errorMesage));
          } else {
            return Center(
              child: Text('Sorry! some unexpected thing occurred.'),
            );
          }
        },
      ),
    );
  }
}
