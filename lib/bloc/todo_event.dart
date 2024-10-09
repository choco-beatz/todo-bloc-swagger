// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

class TodoEvent {}

class FetchTodoEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  TodoModel todo;
  AddTodoEvent({
    required this.todo,
  });
}

class DeleteTodoEvent extends TodoEvent {
  String id;
  DeleteTodoEvent({required this.id});
}

class CompletedTodoEvent extends TodoEvent {
  String id;
  bool isCompleted;
  TodoModel todo;
  CompletedTodoEvent({
    required this.id,
    required this.todo,
    required this.isCompleted,
  });
}

class UpdatedTodoEvent extends TodoEvent {
  String id;
  String title;
  String description;
  bool isCompleted;

  UpdatedTodoEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted
  });
}
