import 'package:flutter_streams/todo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  static Future<List<Todo>> getTasks() async {
    List<Todo> _list = [];
    final response =
        await http.get('https://jsonplaceholder.typicode.com/todos');
    final data = json.decode(response.body);
    _list = data.map<Todo>((todo) => Todo.fromJson(todo)).toList();
    return _list;
  }
}
