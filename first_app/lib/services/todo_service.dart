
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/todo_model.dart';

import 'package:http/http.dart';

abstract class TodoService {
  Future<List<Todo>> getTodos();
  void updateTodo(Todo todo);
}
 
class TodoFirebaseService implements TodoService {
  @override
  Future<List<Todo>> getTodos() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('todos').get();
    AllTodos todos = AllTodos.fromSnapshot(qs);
    return todos.todos;
  }

  @override
  void updateTodo(Todo todo) {
    print('Updating todo id=${todo.id}');
    FirebaseFirestore.instance.collection('todos').doc(todo.id).update({
      'complete' : todo.completed,
    });
  }

}
class TodoHttpService implements TodoService{
  Client client = Client();

  Future<List<Todo>> getTodos() async{
    try{
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
    }catch(e){
     throw Exception("Error while connect backend");
    }
   }
   void updateTodo(Todo todo) async{
      final response = 
    await client.put(
    Uri.parse('http://jsonplaceholder.typicode.com/todos/${todo.id}'),
    headers: <String, String>{
      "Content" :"application/json",
    },
    body:jsonEncode(<String,dynamic>{
    "userId":todo.userId,
    "id":todo.id,
    "title":todo.title,
    "completed" : todo.completed,
    }),
    );
    if(response.statusCode!=200){
    throw Exception("Cannot update todo");
    }
    print(response.body);
   }
  }
