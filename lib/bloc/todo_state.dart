part of 'todo_bloc.dart';

class TodoState {
  final List<TodoModel> todoList;
  final bool isLoading;
  final bool isAdding;
  final bool isSuccess;
  final bool hasError;
  final String message;

  TodoState(
      {required this.todoList,
      this.isLoading = false,
      this.isAdding = false,
      this.isSuccess = false,
      this.hasError = false,
      this.message = ""});
}

final class TodoInitial extends TodoState {
  TodoInitial() : super(todoList: []);
}
