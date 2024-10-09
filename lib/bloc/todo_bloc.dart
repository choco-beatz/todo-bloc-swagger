import 'package:bloc/bloc.dart';
import 'package:todo_bloc/model/todo_model.dart';
import 'package:todo_bloc/services/api.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<FetchTodoEvent>((event, emit) async {
      emit(TodoState(todoList: [], isLoading: true));
      final todos = await fetchTodo();
      
      emit(TodoState(todoList: todos, isLoading: false));
    });

    on<AddTodoEvent>(
      (event, emit) async {
        emit(TodoState(todoList: [], isAdding: true, isLoading: true));
        bool success =
            await addTodo(event.todo); 
        final todos = await fetchTodo();
        if (success) {
          emit(TodoState(
              todoList: todos,
              isAdding: false,
              isLoading: false,
              isSuccess: success,
              message: "Added Successfully"));
        } else {
          emit(TodoState(
              todoList: todos,
              isAdding: false,
              isLoading: false,
              hasError: true,
              message: "Not Added"));
        }
      },
    );

    on<DeleteTodoEvent>((event, emit) async {
      emit(TodoState(todoList: state.todoList, isLoading: true));
      bool success = await deleteTodo(event.id);

      if (success) {
        final todos = await fetchTodo();
        emit(TodoState(
            todoList: todos,
            isAdding: false,
            isLoading: false,
            isSuccess: success,
            message: "Deleted Successfully"));
      } else {
        emit(TodoState(
            todoList: state.todoList,
            isAdding: false,
            isLoading: false,
            hasError: true,
            message: "Not Deleted"));
      }
    });

    on<CompletedTodoEvent>((event, emit) async {
      emit(TodoState(isLoading: true, todoList: state.todoList));

      bool success = await completedTodo(event.id, event.isCompleted, event.todo);

      if (success) {
        final todos = await fetchTodo();
        emit(TodoState(
            todoList: todos,
            isSuccess: success,
            isLoading: false,
            message: "Way to go!!"));
      } else {
        emit(TodoState(
            todoList: state.todoList,
            isLoading: false,
            hasError: true,
            message: "Something went wrong"));
      }
    });

    on<UpdatedTodoEvent>((event, emit) async {
      emit(TodoState(isLoading: true, todoList: state.todoList));

      bool success = await updatedTodo(event.id, event.title, event.description, event.isCompleted);

      if (success) {
        final todos = await fetchTodo();
        emit(TodoState(
            todoList: todos,
            isSuccess: success,
            isLoading: false,
            message: "Edit Successful!!"));
      } else {
        emit(TodoState(
            todoList: state.todoList,
            isLoading: false,
            hasError: true,
            message: "Something went wrong"));
      }
    });
  }
}
