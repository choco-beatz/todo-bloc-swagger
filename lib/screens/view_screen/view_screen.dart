import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/constant/colors.dart';
import 'package:todo_bloc/model/todo_model.dart';
import 'package:todo_bloc/screens/edit_screen/edit_screen.dart';

class ViewTodo extends StatelessWidget {
  final TodoModel todo;
  const ViewTodo({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text("Are you sure you want to delete?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context.read<TodoBloc>().add(
                DeleteTodoEvent(id: todo.id!),
              );
              Navigator.of(context).pop();
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  size: 35,
                )),
          )
        ],
        backgroundColor: white,
        foregroundColor: black,
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 5),
                  child: Text(
                    todo.title,
                    style: const TextStyle(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: 22),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: width,
                  decoration: BoxDecoration(
                      border: Border.all(color: mainColor, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    todo.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.edit_note,
          size: 35,
          color: black,
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Edit(
                      todo: todo,
                    ))),
      ),
    );
  }
}
