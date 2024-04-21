import 'package:cloud_firestore/cloud_firestore.dart';

class Todo{
  final int userId;
  String id = ""; 
  final String title;
  bool completed;

  Todo(this.userId,this.title,this.completed);

  factory Todo.fromJson(Map<String,dynamic> json){
    return Todo(
      json['userId'] as int , 
      json['title'] as String,
      json['completed'] as bool,
    );
  }
} 

class AllTodos {
  final List <Todo> todos;

  AllTodos(this.todos);
  factory AllTodos.fromJson(List<dynamic> json){
    List<Todo> todos;

    todos = json.map((item) => Todo.fromJson(item)).toList();

return AllTodos(todos);
  }
 factory AllTodos.fromSnapshot(QuerySnapshot qs) {
   List<Todo> todos; 
   
   todos = qs.docs.map((DocumentSnapshot ds){
   Todo todo = Todo.fromJson(ds.data()as Map<String,dynamic>);
   todo.id= ds.id;
   return todo;
  } ).toList();
  return AllTodos(todos);
 }
}