
import 'package:delala/core/handlers/dio_client.dart';
import 'package:delala/features/todo/data/model/todo.dart';
import 'package:delala/injector.dart';
import 'package:dio/dio.dart';

class TodoService {
    final _dioClient = sl<DioClient>();
  /// Function to get [Todo] from backend
   Future<Response> fetchTodos() async {
    try{
       final response = await _dioClient.dio.get('/todos');
      
      return response;
    }catch(e){
  
      throw Exception(e);
    }
   }
  //  Future<Response> addTodo(Todo todo) async {
    
  //   try {
  //     final response = await _dioClient.dio.post('/post',data: todo.toJson());
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  //  }
}