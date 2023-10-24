import 'dart:async';

import 'package:first_app/models/todo_model.dart';
import 'package:first_app/services/todo_service.dart';

class TodoController {
  List<Todo> todos = List.empty();
  final TodoHttpService service; 

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;
   
  TodoController(this.service);
  
  Future<List<Todo>> fetchTodos() async {
    onSyncController.add(true);
    todos = await service.getTodos();
    onSyncController.add(false);   
    return todos;
  }
}