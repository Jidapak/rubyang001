
import 'dart:convert';
import 'package:first_app/models/todo_model.dart';
import 'package:http/http.dart';

class TodoHttpService{
  Client client = Client();

  Future<List<Todo>> getTodos() async{
  final response = 
    await client.get(
    Uri.parse('http://jsonplaceholder.typicode.com/todos'),
    );

    if(response.statusCode == 200){
      var all= AllTodos.fromJson(json.decode(response.body));
      return all.todos;
    } else {
    throw Exception('Fail to load todos');
    }
   } 
  }