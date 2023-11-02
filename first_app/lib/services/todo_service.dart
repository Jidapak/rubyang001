
import 'dart:convert';
import 'package:first_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TodoHttpService{
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
