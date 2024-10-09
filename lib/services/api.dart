import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:todo_bloc/model/todo_model.dart';

const baseUrl = 'https://api.nstack.in/v1/todos';

Future<List<TodoModel>> fetchTodo() async {
  List<TodoModel> todos = [];
  try {
    final response = await http.get(Uri.parse("$baseUrl?page=1&limit=10"));

    if (response.statusCode == 200) {
      final todo = jsonDecode(response.body) as Map<String, dynamic>;

      final todoList = todo['items'] as List;

      for (var item in todoList) {
        final todo = TodoModel.fromJson(item as Map<String, dynamic>);
        todos.add(todo);
      }

      return todos;
    } else {
      return [];
    }
  } catch (e) {
    log('error:${e.toString()}');
    return [];
  }
}

Future<bool> addTodo(TodoModel todo) async {
  Map<String, dynamic> data = {
    "title": todo.title,
    "description": todo.description,
    "is_completed": todo.isCompleted,
    "created_at": todo.createdAt.toIso8601String()
  };
  try {
    final response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    log(e.toString());
    return false;
  }
}

Future<bool> deleteTodo(String id) async {
  try {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    log(e.toString());
    return false;
  }
}

Future<bool> completedTodo(String id, bool isCompleted, TodoModel todo) async {
  try {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        'title' : todo.title,
        'is_completed': isCompleted}),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    log(e.toString());
    return false;
  }
}

Future<bool> updatedTodo(String id, String title, String description, bool isCompleted) async {
  try {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        'title' : title,
        'description': description,
        'is_completed': isCompleted}),
    );
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    log(e.toString());
    return false;
  }
}
